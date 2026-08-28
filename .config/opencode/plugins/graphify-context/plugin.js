// graphify-context — opencode plugin
//
// At the start of every session, checks if `graphify-out/graph.json` exists
// in the current working directory. If it does, injects a system-prompt block
// instructing the model to use `graphify query "<question>"` for codebase
// questions instead of manual file searching.
//
// Installed at: ~/.config/opencode/plugins/graphify-context/plugin.js
// Auto-discovered by opencode (no opencode.json entry needed).

import { existsSync, readFileSync } from 'node:fs';
import { join, resolve } from 'node:path';

const GRAPH_RELATIVE = 'graphify-out/graph.json';

function buildSystemBlock(graphPath, stats) {
  const lines = [
    '## Knowledge Graph Available',
    '',
    `A pre-built knowledge graph exists at \`${GRAPH_RELATIVE}\`${stats ? ` (${stats.nodes} nodes, ${stats.edges} edges, ${stats.communities} communities)` : ''}.`,
    '',
    'For any question about this codebase — architecture, file relationships, what calls what, how things connect — prefer running:',
    '',
    '```bash',
    'graphify query "<your question>"',
    '```',
    '',
    'Examples:',
    '- `graphify query "how does the ingress setup work"`',
    '- `graphify query "what connects the deployment pipeline to Terraform"`',
    '- `graphify query "how are secrets injected into pods"`',
    '',
    'Do NOT rebuild the graph unless the user explicitly asks. Use the existing graph.',
  ];
  return lines.join('\n');
}

function readGraphStats(graphPath) {
  try {
    const raw = JSON.parse(readFileSync(graphPath, 'utf8'));
    const nodes = Array.isArray(raw.nodes) ? raw.nodes.length : '?';
    const edges = Array.isArray(raw.edges) ? raw.edges.length : '?';
    // communities: count unique community values in nodes
    const communities = raw.nodes
      ? new Set(raw.nodes.map(n => n.community).filter(c => c != null)).size
      : '?';
    return { nodes, edges, communities: communities || '?' };
  } catch {
    return null;
  }
}

const GraphifyContextPlugin = async (_ctx) => {
  const cwd = process.cwd();
  const graphPath = resolve(cwd, GRAPH_RELATIVE);
  const graphExists = existsSync(graphPath);

  if (!graphExists) {
    // No graph — do nothing
    return {};
  }

  const stats = readGraphStats(graphPath);
  const systemBlock = buildSystemBlock(graphPath, stats);

  return {
    // Inject into the system prompt for every chat turn
    'experimental.chat.system.transform': async (_input, output) => {
      // Append only once — avoid duplicating on every turn
      const marker = '## Knowledge Graph Available';
      if (!output.system.includes(marker)) {
        output.system = output.system
          ? output.system + '\n\n' + systemBlock
          : systemBlock;
      }
    },
  };
};

export default GraphifyContextPlugin;

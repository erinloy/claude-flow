#!/bin/bash

# Claude-Flow Workflow Shortcuts
# Quick commands for common operations

# Initialize swarm with optimized topology
alias cf-init='npx claude-flow@alpha mcp call swarm_init "mesh" 8 "auto"'

# Spawn development team
alias cf-dev-team='npx claude-flow@alpha mcp batch agent_spawn researcher,coder,tester,reviewer'

# Store memory checkpoint
cf-checkpoint() {
    npx claude-flow@alpha memory store "checkpoint/$(date +%s)" "$1" --namespace workflow
}

# Neural training for patterns
cf-train() {
    npx claude-flow@alpha mcp call neural_train "$1" "$2" 50
}

# Performance monitoring
alias cf-perf='npx claude-flow@alpha mcp call performance_report detailed 24h'

# Quick workflow execution
cf-workflow() {
    npx claude-flow@alpha workflow execute "$1" --params "$2"
}

# Session management
cf-session-save() {
    npx claude-flow@alpha mcp call memory_persist "session_$(date +%s)"
}

cf-session-restore() {
    npx claude-flow@alpha hooks session-restore --session-id "$1"
}

# Swarm monitoring
alias cf-monitor='npx claude-flow@alpha mcp call swarm_monitor'

# Agent status
alias cf-agents='npx claude-flow@alpha mcp call agent_list'

# Memory search
cf-search() {
    npx claude-flow@alpha memory search "$1" --limit 10
}

echo "Claude-Flow shortcuts loaded! Commands:"
echo "  cf-init           - Initialize swarm"
echo "  cf-dev-team       - Spawn development team"
echo "  cf-checkpoint     - Store memory checkpoint"
echo "  cf-train          - Train neural patterns"
echo "  cf-perf           - Performance report"
echo "  cf-workflow       - Execute workflow"
echo "  cf-session-save   - Save session"
echo "  cf-session-restore - Restore session"
echo "  cf-monitor        - Monitor swarm"
echo "  cf-agents         - List agents"
echo "  cf-search         - Search memory"
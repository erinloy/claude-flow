# Windows Compatibility Improvements

This fork contains critical Windows compatibility fixes for claude-flow that enable full functionality on Windows systems.

## Problems Solved

### 1. Database Schema Error
**Issue**: `table sessions has no column named swarm_name`
- Hive-mind spawn would fail immediately on Windows
- Database initialization created incomplete schema

**Solution**: Updated `src/cli/simple-commands/init/hive-mind-init.js`
- Added missing `swarm_name` column to sessions table
- Added `session_checkpoints` and `session_logs` tables
- Synchronized schema with session-manager.js requirements

### 2. Claude CLI Detection Failure
**Issue**: `Claude Code CLI not found in PATH`
- Used Unix-only `which` command for detection
- Failed even when Claude was properly installed

**Solution**: Created cross-platform detection in `src/utils/claude-detector.js`
- Uses `where` on Windows, `which` on Unix
- Fallback to direct `claude --version` test
- Reusable utility for consistent detection

### 3. Spawn ENOENT Error
**Issue**: `Error: spawn claude ENOENT`
- Child process spawn failed to find claude command
- Windows requires shell execution for PATH resolution

**Solution**: Updated spawn calls in `src/cli/simple-commands/hive-mind.js`
- Set `shell: true` on Windows platform
- Maintains `shell: false` on Unix for security
- Proper command execution across platforms

### 4. MCP Server stdio Handling
**Issue**: MCP server would close immediately on Windows
- stdio communication issues between processes

**Solution**: Fixed in `src/cli/simple-commands/mcp.js` and `src/mcp/mcp-server.js`
- Proper stdio handling for Windows environment
- Maintains compatibility with Unix systems

## Files Modified

```
src/cli/simple-commands/hive-mind.js           - Claude detection & spawn fixes
src/cli/simple-commands/init/hive-mind-init.js - Database schema fixes
src/utils/claude-detector.js                   - NEW: Cross-platform CLI detection
src/cli/simple-commands/mcp.js                 - MCP stdio handling
src/mcp/mcp-server.js                          - Server stdio fixes
```

## Testing

All changes have been tested on:
- Windows 11 with PowerShell 7
- Git Bash (MSYS) on Windows
- Node.js v24.5.0

## Usage

```bash
# Initialize hive-mind (creates proper database schema)
claude-flow hive-mind init --force

# Spawn hive-mind swarm (now works on Windows)
claude-flow hive-mind spawn "your objective" --monitor --claude

# Claude CLI integration fully functional
claude-flow hive-mind spawn "task" --claude
```

## Compatibility

- ✅ Maintains full backward compatibility with Unix/Linux/macOS
- ✅ No breaking changes to existing functionality
- ✅ All fixes are platform-aware and conditional
- ✅ Upstream changes can be merged without conflicts

## Contributing

These fixes are essential for Windows users of claude-flow. Consider submitting as PR to upstream repository to benefit the wider community.
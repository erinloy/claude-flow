# Claude-Flow Windows Compatibility Fork

**Fork Maintainer**: @erinloy  
**Upstream**: https://github.com/ruvnet/claude-flow  
**Purpose**: Critical Windows compatibility fixes for production use

## Why This Fork Exists

The upstream claude-flow project has excellent functionality but encounters several blocking issues on Windows systems. This fork provides production-ready fixes that enable full functionality on Windows while maintaining complete compatibility with Unix/Linux/macOS systems.

## Key Improvements

### ✅ Fixed: Database Schema Issues
- Hive-mind spawn now works without schema errors
- Complete table definitions with all required columns
- Proper foreign key relationships

### ✅ Fixed: Claude CLI Detection
- Cross-platform command detection (where/which)
- Fallback detection methods
- Reliable CLI availability checking

### ✅ Fixed: Process Spawning
- Windows shell execution support
- PATH resolution for commands
- No more ENOENT errors

### ✅ Fixed: MCP Server Communication
- Proper stdio handling on Windows
- Stable server connections
- Reliable inter-process communication

## Installation

```bash
# Install this fork directly
npm install -g github:erinloy/claude-flow

# Or clone and link locally
git clone https://github.com/erinloy/claude-flow.git
cd claude-flow
npm install
npm link
```

## Verification

Test that Windows fixes are working:

```bash
# Check Claude CLI detection
claude-flow hive-mind spawn "test" --claude

# Verify database schema
claude-flow hive-mind init --force
claude-flow hive-mind spawn "hello world"

# Test MCP server
claude-flow mcp start
```

## Maintaining This Fork

### Syncing with Upstream

```bash
# Add upstream remote
git remote add upstream https://github.com/ruvnet/claude-flow.git

# Fetch and merge upstream changes
git fetch upstream
git merge upstream/main

# Push to fork
git push origin main
```

### Testing Windows Compatibility

Before merging upstream changes, always test:
1. Hive-mind spawn functionality
2. Claude CLI integration
3. MCP server startup
4. Database operations

## Contributing

### To This Fork
- Test all changes on Windows
- Maintain cross-platform compatibility
- Document Windows-specific fixes

### To Upstream
Consider submitting these fixes as PRs to benefit the community:
- Database schema synchronization
- Cross-platform CLI detection utility
- Windows spawn handling

## Technical Details

See [WINDOWS_COMPATIBILITY.md](WINDOWS_COMPATIBILITY.md) for detailed technical documentation of all fixes.

## License

Same as upstream - Apache 2.0

## Support

For Windows-specific issues with this fork:
- Open issues at: https://github.com/erinloy/claude-flow/issues
- Tag with: `windows-compatibility`

For general claude-flow issues:
- See upstream: https://github.com/ruvnet/claude-flow

---

**Note**: This fork is actively maintained to ensure Windows compatibility while tracking upstream changes. All fixes are designed to be non-breaking and suitable for eventual upstream integration.
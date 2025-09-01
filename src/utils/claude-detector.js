/**
 * Cross-platform Claude CLI detection utility
 */

import { execSync } from 'child_process';

/**
 * Check if Claude CLI is available on the system
 * @returns {boolean} True if Claude CLI is available, false otherwise
 */
export function isClaudeAvailable() {
  try {
    // First try platform-specific command
    const checkCommand = process.platform === 'win32' ? 'where claude' : 'which claude';
    execSync(checkCommand, { stdio: 'ignore' });
    return true;
  } catch {
    // Fallback: try to run claude directly
    try {
      execSync('claude --version', { stdio: 'ignore' });
      return true;
    } catch {
      return false;
    }
  }
}

/**
 * Get Claude CLI version
 * @returns {string|null} Version string or null if not available
 */
export function getClaudeVersion() {
  try {
    const version = execSync('claude --version', { encoding: 'utf8' }).trim();
    return version;
  } catch {
    return null;
  }
}

/**
 * Find Claude executable path
 * @returns {string|null} Path to Claude executable or null if not found
 */
export function getClaudePath() {
  try {
    if (process.platform === 'win32') {
      // On Windows, 'where' returns the full path
      const result = execSync('where claude', { encoding: 'utf8' }).trim();
      // Take the first line if multiple results
      return result.split('\n')[0].trim();
    } else {
      // On Unix-like systems, 'which' returns the path
      return execSync('which claude', { encoding: 'utf8' }).trim();
    }
  } catch {
    // Fallback: check common locations
    const npmGlobalPath = process.platform === 'win32'
      ? `${process.env.APPDATA}\\npm\\claude.cmd`
      : `${process.env.HOME}/.npm-global/bin/claude`;
    
    try {
      execSync(`"${npmGlobalPath}" --version`, { stdio: 'ignore' });
      return npmGlobalPath;
    } catch {
      return null;
    }
  }
}

export default {
  isClaudeAvailable,
  getClaudeVersion,
  getClaudePath
};
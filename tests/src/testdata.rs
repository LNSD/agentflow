//! Test data loading utilities.
//!
//! This module provides utilities for loading test data files from the
//! `tests/tests/data/` directory.
//!
//! # Test Data Resolution
//!
//! **Source directories searched (in order):**
//! - `tests/tests/data/` (when running from workspace root)
//! - `tests/data/` (when running from within the `tests/` directory)
//!
//! Use `resolve_file()` to find test data files, or `resolve_dir()` to find
//! test data directories.
//!
//! # Resolution Process
//!
//! When resolving test data, this module uses a search algorithm:
//! 1. **Search in order**: Each source directory is checked sequentially
//! 2. **First match wins**: The first existing file/directory is used
//! 3. **Canonicalization**: Paths are resolved to absolute, canonical paths
//! 4. **Type verification**: Files must exist as files, directories as directories
//! 5. **None on missing**: If no match is found, `None` is returned

use std::path::{Path, PathBuf};

/// Source directories to search for test data.
const TEST_DATA_DIRS: [&str; 2] = ["tests/tests/data", "tests/data"];

/// Resolve a test data file path.
///
/// Searches the predefined test data directories for the specified file.
/// Returns the first canonicalized absolute path where the file exists.
pub fn resolve_file(name: &Path) -> Option<PathBuf> {
    resolve_source_file(&TEST_DATA_DIRS, name)
}

/// Resolve a test data directory path.
///
/// Searches the predefined test data directories for the specified directory.
/// Returns the first canonicalized absolute path where the directory exists.
pub fn resolve_dir(name: &Path) -> Option<PathBuf> {
    resolve_source_dir(&TEST_DATA_DIRS, name)
}

/// Resolves the absolute path to a file by searching through known directories.
///
/// Searches through the provided directories in order, looking for the specified file.
/// Returns the first canonicalized absolute path where the file exists as a regular file.
fn resolve_source_file(dirs: &[&str], name: &Path) -> Option<PathBuf> {
    dirs.iter()
        .map(|dir| Path::new(dir).join(name))
        .filter_map(|file_path| file_path.canonicalize().ok())
        .find(|path| path.is_file())
}

/// Resolves the absolute path to a directory by searching through known directories.
///
/// Searches through the provided directories in order, looking for the specified directory.
/// Returns the first canonicalized absolute path where the directory exists as a directory.
fn resolve_source_dir(dirs: &[&str], name: &Path) -> Option<PathBuf> {
    dirs.iter()
        .map(|dir| Path::new(dir).join(name))
        .filter_map(|dir_path| dir_path.canonicalize().ok())
        .find(|path| path.is_dir())
}

//! Isolated test environment creation.
//!
//! This module provides utilities for creating completely isolated test environments using
//! temporary directories. Each test environment gets its own directory, eliminating any
//! coupling between tests.
//!
//! # Key Features
//!
//! - **Complete isolation**: Each test gets its own temporary directory
//! - **Builder pattern**: Fluent API for environment customization
//! - **Automatic cleanup**: Temporary directories cleaned up on drop (unless `TESTS_KEEP_TEMP_DIRS=1` is set)

use std::path::Path;

use anyhow::Result;

use super::env_dir::TestEnvDir;

pub struct TestCtxBuilder {
    test_name: String,
}

impl TestCtxBuilder {
    /// Create a new test environment builder.
    pub fn new(test_name: impl Into<String>) -> Self {
        Self {
            test_name: test_name.into(),
        }
    }

    /// Build the isolated test environment.
    ///
    /// Creates a temporary directory and returns a ready-to-use test environment.
    pub fn build(self) -> Result<TestCtx> {
        let test_dir = TestEnvDir::new(&self.test_name)?;
        tracing::info!(
            "Creating isolated test environment at: {}",
            test_dir.path().display()
        );

        Ok(TestCtx {
            test_name: self.test_name,
            test_dir,
        })
    }
}

/// An isolated test environment with its own temporary directory.
///
/// This struct represents a test environment that is ready for use.
/// It contains the temporary directory and convenience methods for
/// interacting with the environment.
pub struct TestCtx {
    test_name: String,
    test_dir: TestEnvDir,
}

impl TestCtx {
    /// Get the test name.
    pub fn test_name(&self) -> &str {
        &self.test_name
    }

    /// Get the path to the test environment directory.
    pub fn path(&self) -> &Path {
        self.test_dir.path()
    }

    /// Get a reference to the temporary test directory.
    pub fn test_dir(&self) -> &TestEnvDir {
        &self.test_dir
    }
}

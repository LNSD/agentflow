//! Test infrastructure for creating isolated test environments.
//!
//! # Module Organization
//!
//! - [`ctx`]: High-level test environment creation and management
//! - [`env_dir`]: Temporary directory management
//! - [`testdata`]: Test data file loading utilities
//! - [`fixtures`]: Test fixtures
//! - [`helpers`]: Common test helper functions
//! - [`debug`]: Debug utilities and environment variable handling

pub mod build_info;
pub mod ctx;
pub mod debug;
mod env_dir;
pub mod fixtures;
pub mod helpers;
#[allow(dead_code)]
mod testdata;


//! Low-level test fixtures and directory utilities.
//!
//! This module provides access to the underlying fixture types for advanced use cases
//! requiring direct directory manipulation. For most testing scenarios, use the [`ctx`]
//! module which provides the high-level [`TestCtxBuilder`](ctx::TestCtxBuilder) API.
//!
//! The fixtures module serves test authors who need direct access to temporary
//! directory structures and file operations within their test environments.
//! All fixture types maintain the same isolation and cleanup guarantees as the
//! parent testlib infrastructure.

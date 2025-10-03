+++
title = "Observations from outside Meta"
draft = false
description = "This article is a collection of observations from the point of view of an ex-Meta (formerly Facebook) engineer of 14 years now working in other companies."
categories = ["articles"]
tags = ["work", "meta", "facebook"]
+++

This article is a collection of observations from the point of view of an ex-Meta (formerly Facebook) engineer of 14 years now working in other companies.

**It will evolve over time as I work in different places and observe how things are done differently.**

## Things I am liking

- **Fast compilation time**: Where I am now, compilation times are very fast. At Meta, building binaries often took a long time, like 20-30 minutes from cold cache. Here it's more like 1-2 minutes. This is a huge productivity boost. Monorepo and huge C++ dependencies really slow things down and make for huge multi-gigabyte statically linked binaries. Which was a pain also to build OS images and ramdisks, and slowed down provisoining.

## Things I am not liking

- **I miss stacked diffs** and the internal Meta `hg` fork. I am doing just okay using `jj`, but `gitlab` has no official support for stacked MRs. There is an experimental `glab stack` CLI I need to use
- **I miss monorepo**: Finding code and searching code is harder in multiple repos. I also miss the ability to make cross-repo changes in a single commit. I also miss the ability to perform large-scale refactors across the codebase.

## Things that are similar

- **OS/Images build times**: Building images is still slow, just as it was at Meta too.
---
title: "Observations from Outside Meta"
date: 2025-10-04T09:00:00+01:00
draft: false
author: "Angelo Failla"
description: "My observations after leaving Meta after 14 years"
categories: ["career"]
tags: ["meta", "facebook", "career", "work"]
featured_image: "meta.jpg"
images: ["meta.jpg"]
---

This article is a collection of observations from the point of view of an
ex-Meta (formerly Facebook) engineer of 14 years who is now working in other
companies.

**It will evolve over time as I work in different places and observe how
things are done differently.**

## The good

- **Fast compilation time**: Where I am now, compilation times are very fast.
  At Meta, building binaries often took a long time — 20–30 minutes from cold
  cache. Here it's more like 1–2 minutes. This is a huge productivity boost.
  Monorepo and huge C++ dependencies really slow things down and produce
  multi-gigabyte statically linked binaries. That made building OS images and
  ramdisks painful and slowed down provisioning.

- **Open Source Ecosystem**: It's refreshing to work with widely used open
  source solutions instead of internal tools. Being in a closed ecosystem for
  a long time is not good for your career. Many internal tools have external
  counterparts, but using projects like Kubernetes, ArgoCD, Grafana, Victoria
  Metrics, and NetBox means I can:

  - Find solutions and troubleshooting tips via public documentation and
    community forums.
  - Contribute back to the community and share knowledge openly.
  - Apply my learning across different companies and contexts.
  - Leverage the collective experience of the industry instead of being
    limited to internal knowledge.

  While Meta's internal tools were powerful and purpose-built, working with
  open source tools makes knowledge more portable and collaborative.

- **I am enjoying Slack but I miss Workplace groups**: Believe it or not I am
  enjoying Slack — it's more responsive than Workplace Messenger and the
  integrations are great. I do miss Workplace groups, though. I feel like
  `slack` is too synchronous; I should try to treat it more like an async tool
  and use features such as saving threads for later.

## The bad

- **I miss stacked diffs**, the internal review flows, the internal Meta `hg` fork.
  I'm doing okay using `jj`, but GitLab has no official support for stacked merge requests.
  There is an experimental `glab stack` CLI I need to use. The diff reviewing
  experience is not on par with Phabricator.

- **I miss monorepo**: Finding and searching code is harder across multiple
  repositories. I also miss being able to make cross-repo changes in a single
  commit and the ability to perform large-scale refactors across the codebase.

- **YAML everywhere!**: YAML on k8s manifests, YAML on CI/CD pipelines, YAML on
  config files, YAML in Helm charts, YAML in Ansible. I miss
  [`configerator`](https://research.facebook.com/publications/holistic-configuration-management-at-facebook/)
  (aka configuration as code).

- **You miss a lot of internal tools**, but the
  [xfb2xfb github repo helps!](https://github.com/greko6/xfb2xfb)

## The same

- **OS/Images build times**: Building images is still slow, just as it was at
  Meta.
- **Timezone differences**: I don't think I can get rid of that, it's just the
  nature of the work... Still need to work on raising awareness about TZ differences
  and TZ etiquette.

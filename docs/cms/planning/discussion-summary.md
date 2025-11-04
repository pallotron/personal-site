# CMS Implementation Discussion Summary

**Date:** November 4, 2025
**Project:** Hugo Website CMS Frontend for Non-Technical Users
**Site:** pallotron/site

---

## Overview

This document summarizes the key questions and decisions made during the CMS planning discussion. After analyzing the Hugo site structure (23 content files across 5 content types), we evaluated different CMS approaches and settled on **Decap CMS** as the recommended solution.

---

## Decision: Decap CMS with Editorial Workflow

**Selected Solution:** Decap CMS (formerly Netlify CMS)
**Rationale:**

- Free and open source
- Quick setup (1-2 hours)
- Git-based (no database needed)
- Works with existing Cloudflare Pages deployment
- Supports editorial workflow with PR-based review

---

## Key Questions & Answers

### Q1: Where Do I Deploy Decap CMS?

**Answer:** You don't need a separate deployment. Decap CMS lives inside your Hugo site as static files.

**Technical Details:**

```text
hugo-site/
├── static/
│   └── admin/
│       ├── index.html      # Single-page React app (the CMS)
│       └── config.yml       # CMS configuration
```

**How It Works:**

1. Add two files to `static/admin/` in your Hugo site
2. Hugo builds and copies them to `public/admin/`
3. Access the CMS at `https://yoursite.com/admin/`
4. The CMS runs entirely in the browser
5. Makes API calls directly to GitHub to read/write files
6. No backend server required

**Authentication:**

- Users authenticate via GitHub OAuth
- Requires setting up a GitHub OAuth app (one-time setup)
- Works perfectly with Cloudflare Pages

---

### Q2: Does Decap CMS Work OK on Mobile?

**Answer:** Limited support - functional but not ideal for extensive content creation.

**Details:**

✅ **What Works:**

- Basic editing (create/edit posts, change text fields)
- Responsive UI adapts to mobile screens
- Quick fixes and typo corrections

⚠️ **Limitations:**

- Markdown editor is cramped on mobile
- Writing long posts on mobile is tedious
- Image uploads can be finicky (mobile browser file handling)
- Not optimized for touch interactions

❌ **Not Recommended:**

- Writing full blog posts on mobile
- Complex content with multiple images
- Heavy editing sessions

**Reality Check:**
Most users do quick edits on mobile (fix typos, change dates, update metadata) but write full posts on desktop.

**Alternatives If Mobile Is Critical:**

- **Forestry.io / CloudCannon** - Better mobile apps
- **Custom CMS** - Could build mobile-first PWA
- **Tina CMS** - Slightly better mobile experience

**Recommendation:** Accept desktop-first workflow, mobile for quick edits only.

---

### Q3: Can Decap CMS Work with Git Branches and Pull Requests?

**Answer:** Yes! This is one of Decap CMS's best features via "Editorial Workflow" mode.

**How Editorial Workflow Works:**

**Content Lifecycle:**

```text
Draft → In Review → Ready → Published
  ↓         ↓          ↓         ↓
(local)  (branch)   (branch)   (main)
```

**Behind the Scenes:**

1. **User creates content** → Decap creates branch: `cms/posts/my-new-post`
2. **User marks "In Review"** → Decap opens GitHub Pull Request
3. **You review** → Cloudflare Pages auto-generates preview URL
4. **User marks "Ready"** → PR ready for merge
5. **User clicks "Publish"** → Decap auto-merges PR to `main`

**Configuration:**

```yaml
# In static/admin/config.yml
backend:
  name: github
  repo: pallotron/site
  branch: main

publish_mode: editorial_workflow
cms_label_prefix: cms/
```

---

### Cloudflare Pages Integration

**Automatic Preview Deployments:**

Every PR automatically gets a preview URL:

```text
PR #123: "Add new blog post about containers"
├── Preview URL: https://abc123.yoursite.pages.dev
├── Review the fully rendered site
└── Merge when satisfied (or let Decap merge via "Publish")

**Workflow in Practice:**

**Non-Technical User:**

1. Logs into `yoursite.com/admin/`
2. Creates new blog post in CMS UI
3. Saves as "Draft" (only visible to them in CMS)
4. When ready, moves to "In Review" → **PR auto-created**
5. Notification sent (GitHub, email, Slack, etc.)
6. Waits for approval
7. After approval, clicks "Publish" → **PR auto-merges**

**Technical Reviewer (You):**

1. Receives GitHub notification about new PR
2. Clicks Cloudflare Pages preview link in PR
3. Reviews the rendered site (not just markdown)
4. Options:
   - **Approve** → User can publish from CMS
   - **Request changes** → User edits in CMS, PR updates automatically
   - **Merge manually** → Bypass CMS, merge in GitHub directly
   - **Close PR** → Reject content

**Benefits:**

- ✅ Non-technical users never touch git/GitHub
- ✅ Full PR-based review workflow maintained
- ✅ Preview before production
- ✅ Complete git history
- ✅ You retain full control

**Caveats:**

- ⚠️ GitHub OAuth app needs write permissions (branch/PR creation)
- ⚠️ One PR per content item (many drafts = many PRs)
- ⚠️ PR list can get cluttered if users create many drafts
- ✅ You can always review/edit/reject in GitHub directly

---

## Approach Comparison

### Options Evaluated

#### 1. Custom Web Application

**Description:** Build dedicated React/Node.js app
**Pros:** Full control, tailored to exact needs
**Cons:** 4-13 weeks dev time, ongoing maintenance
**Verdict:** Overkill for current needs

#### 2. Decap CMS (Chosen)

**Description:** Open source, git-based CMS
**Pros:** Free, quick setup (1-2 hours), PR workflow, self-hosted
**Cons:** Limited mobile, basic UI
**Verdict:** ✅ Best fit for requirements

#### 3. Tina CMS

**Description:** Modern React-based CMS with visual editing
**Pros:** Better UX, real-time preview
**Cons:** Requires more setup, potential costs
**Verdict:** Consider for future upgrade

#### 4. Commercial Solutions (Forestry/CloudCannon)

**Description:** Hosted Hugo-specific CMS
**Pros:** Best mobile support, polished UI
**Cons:** Monthly costs ($9-29/month)
**Verdict:** If budget allows and mobile is critical

#### 5. Headless CMS (Contentful/Sanity)

**Description:** API-first CMS with Hugo integration layer
**Pros:** Best content modeling, multi-channel
**Cons:** Monthly costs, complex integration
**Verdict:** Over-engineered for blog use case

---

## Critical Site Issues to Address

Based on the site analysis, these issues should be resolved before or during CMS setup:

### 1. Mixed Frontmatter Formats

**Problem:** Site uses both TOML (`+++`) and YAML (`---`) formats
**Impact:** Complicates parsing, error-prone
**Solution:** Standardize to YAML (Decap CMS default)
**Action:** Convert remaining TOML files to YAML

### 2. Inconsistent Image Handling

**Problem:** Some posts use `featured_image`, others use `images[]`
**Impact:** Templates may not display images consistently
**Solution:** Standardize on single approach (recommend both fields for flexibility)
**Action:** Update CMS config to populate both fields

### 3. Complex Post Paths

**Problem:** Posts use `/posts/YYYY/MM/DD/slug/` structure
**Impact:** Manual path creation prone to errors
**Solution:** CMS auto-generates paths from date + slug
**Action:** Configure Decap CMS to handle path generation

### 4. Unused Taxonomies

**Problem:** Config enables "tags" but some content uses "categories"
**Impact:** Inconsistent content organization
**Solution:** Remove "categories" or add as proper taxonomy
**Action:** Decide on single taxonomy approach

---

## Final Recommendation

### Proceed with Decap CMS using Editorial Workflow

**Why This Is the Right Choice:**

1. ✅ Meets core requirement: non-technical users can create content
2. ✅ Preserves PR-based review workflow with Cloudflare previews
3. ✅ Zero hosting costs (static files in your repo)
4. ✅ Quick implementation (1-2 hours setup)
5. ✅ Git-based (full history, no vendor lock-in)
6. ✅ Proven solution (widely used in Hugo community)

**Accept These Trade-offs:**

1. ⚠️ Mobile experience is limited (desktop-first workflow)
2. ⚠️ Basic UI (not as polished as commercial options)
3. ⚠️ PR list can get cluttered with many drafts

**You Retain Full Control:**

- Can edit content directly in GitHub
- Can merge/reject PRs manually
- Can add custom validation (pre-commit hooks, CI checks)
- Can migrate to different CMS later (content stays in git)

---

## Next Steps

1. ✅ **Documentation Complete** - This discussion summary
2. ⏭️ **Review Implementation Plan** - See `implementation-plan.md`
3. ⏭️ **Set Up Decap CMS** - Create config files
4. ⏭️ **Configure GitHub OAuth** - Enable authentication
5. ⏭️ **Test Locally** - Verify CMS works with Hugo site
6. ⏭️ **Deploy** - Commit and push to trigger Cloudflare build
7. ⏭️ **User Testing** - Have non-technical users try it out

---

## References

- **Site Analysis:** See `/docs/cms/analysis/` directory
- **Implementation Plan:** See `implementation-plan.md`
- **Decap CMS Docs:** <https://decapcms.org/>
- **Editorial Workflow:** <https://decapcms.org/docs/configuration-options/#publish-mode>
- **GitHub Backend:** <https://decapcms.org/docs/github-backend/>

---

**Document Status:** Complete
**Ready to Proceed:** Yes
**Blockers:** None

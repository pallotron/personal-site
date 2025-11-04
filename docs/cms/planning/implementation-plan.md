# Decap CMS Implementation Plan

**Project:** Hugo Website CMS for Non-Technical Users
**Site:** pallotron/site (<https://github.com/pallotron/site>)
**CMS Solution:** Decap CMS with Editorial Workflow
**Timeline:** 1-2 hours setup + testing
**Last Updated:** November 4, 2025

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Prerequisites](#prerequisites)
3. [Implementation Steps](#implementation-steps)
4. [Configuration Details](#configuration-details)
5. [GitHub OAuth Setup](#github-oauth-setup)
6. [Testing Plan](#testing-plan)
7. [Deployment](#deployment)
8. [User Onboarding](#user-onboarding)
9. [Troubleshooting](#troubleshooting)
10. [Future Enhancements](#future-enhancements)

---

## Executive Summary

**Objective:** Enable non-technical users to create and manage content on the Hugo website without knowledge of markdown, git, or Hugo.

**Solution:** Decap CMS - an open-source, git-based CMS that runs as static files within the Hugo site.

**Key Features:**

- ✅ Web-based content editor at `yoursite.com/admin/`
- ✅ Editorial workflow with PR-based review
- ✅ Cloudflare Pages preview integration
- ✅ Zero hosting costs
- ✅ Full git history maintained
- ✅ Support for 5 content types: Posts, Articles, Projects, Public Talks, Pages

**Timeline:**

- Setup: 1 hour
- Testing: 30 minutes
- User onboarding: 30 minutes

---

## Prerequisites

### Required

- [x] GitHub repository: `pallotron/site`
- [x] Cloudflare Pages deployment configured
- [x] Hugo site with content in `content/` directory
- [ ] GitHub account with admin access to the repo
- [ ] Local Hugo development environment

### Nice to Have

- [ ] Test GitHub account for user testing
- [ ] Staging environment (Cloudflare provides PR previews)

---

## Implementation Steps

### Step 1: Create CMS Directory Structure

Create the admin directory in Hugo's `static/` folder:

```bash
mkdir -p static/admin
```

This will contain:

- `index.html` - The Decap CMS application
- `config.yml` - CMS configuration for your content types

---

### Step 2: Create `static/admin/index.html`

This is the single-page application that loads Decap CMS.

**File:** `static/admin/index.html`

```html
<!doctype html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="robots" content="noindex" />
  <title>Content Manager</title>
</head>
<body>
  <!-- Include the Decap CMS script -->
  <script src="https://unpkg.com/decap-cms@^3.0.0/dist/decap-cms.js"></script>
</body>
</html>
```

**What This Does:**

- Loads the Decap CMS React application from CDN
- Reads configuration from `config.yml` in the same directory
- Provides the editing interface at `/admin/`

---

### Step 3: Create `static/admin/config.yml`

This is the heart of the CMS - it defines your content types, fields, and workflow.

**File:** `static/admin/config.yml`

See [Configuration Details](#configuration-details) section below for the complete configuration.

---

### Step 4: Set Up GitHub OAuth

Decap CMS needs GitHub authentication to read/write files.

**Options:**

#### Option A: GitHub as OAuth Provider (Recommended)

Use GitHub's OAuth directly - simple and free.

**Steps:**

1. Go to GitHub Settings → Developer settings → OAuth Apps
2. Click "New OAuth App"
3. Fill in:
   - **Application name:** `Hugo CMS - YourSiteName`
   - **Homepage URL:** `https://yoursite.com`
   - **Authorization callback URL:** `https://api.netlify.com/auth/done`
     (Yes, use Netlify's callback even though you're on Cloudflare - it's a generic OAuth handler)
4. Click "Register application"
5. Note the **Client ID** and generate a **Client Secret**

**Update `config.yml`:**

```yaml
backend:
  name: github
  repo: pallotron/site
  branch: main
  auth_endpoint: auth
```

**Limitation:** All users need GitHub accounts with write access to your repo.

#### Option B: Cloudflare Pages Function (Advanced)

Create a serverless function to handle OAuth without exposing secrets.

**When to Use:** If you want users without GitHub write access, or need more control.

**Trade-off:** More complex setup (requires Cloudflare Pages Functions).

For initial setup, **Option A is recommended**.

---

### Step 5: Configure Content Collections

Define each content type in `config.yml`. Your site has 5 types:

1. **Blog Posts** (`content/posts/`)
2. **Articles** (`content/articles/`)
3. **Projects** (`content/projects/`)
4. **Public Talks** (`content/public-talks/`)
5. **Pages** (`content/pages/`)

See [Configuration Details](#configuration-details) for complete collection definitions.

---

### Step 6: Test Locally

Before deploying, test the CMS locally:

```bash
# Start Hugo server
hugo server -D

# In another terminal, run Decap CMS proxy for local auth
npx decap-server
```

Then visit:

- **Your site:** <http://localhost:1313/>
- **CMS admin:** <http://localhost:1313/admin/>

**Test Checklist:**

- [ ] Can access `/admin/` without errors
- [ ] Can log in (uses local proxy, no GitHub auth needed)
- [ ] Can see all 5 content collections
- [ ] Can view existing content
- [ ] Can create a new draft post
- [ ] Changes appear in filesystem immediately
- [ ] Can preview markdown rendering

---

### Step 7: Enable Editorial Workflow

This enables the PR-based review process.

**In `config.yml`:**

```yaml
publish_mode: editorial_workflow
```

**What This Enables:**

- Draft status (local only, not committed)
- In Review status (creates branch + PR)
- Ready status (PR approved, ready to merge)
- Published status (merged to main)

---

### Step 8: Deploy to Production

Commit the CMS files:

```bash
git add static/admin/
git commit -m "Add Decap CMS for content management

- Add CMS interface at /admin/
- Configure editorial workflow with PR-based review
- Support for all 5 content types (posts, articles, projects, talks, pages)
- Integrate with Cloudflare Pages preview deployments"

git push origin main
```

Cloudflare Pages will automatically build and deploy.

After deployment, visit `https://yoursite.com/admin/` to verify.

---

## Configuration Details

### Complete `config.yml` Example

```yaml
# Backend configuration
backend:
  name: github
  repo: pallotron/site
  branch: main

# Enable PR-based editorial workflow
publish_mode: editorial_workflow

# Media files configuration
media_folder: "static/images/uploads"
public_folder: "/images/uploads"

# Collections (content types)
collections:
  # ============================================
  # BLOG POSTS
  # ============================================
  - name: "posts"
    label: "Blog Posts"
    label_singular: "Blog Post"
    folder: "content/posts"
    path: "{{year}}/{{month}}/{{day}}/{{slug}}/index"
    create: true
    slug: "{{slug}}"
    preview_path: "posts/{{year}}/{{month}}/{{day}}/{{slug}}/"

    # Media files colocated with content
    media_folder: "images"
    public_folder: "images"

    fields:
      - label: "Title"
        name: "title"
        widget: "string"
        required: true

      - label: "Publish Date"
        name: "date"
        widget: "datetime"
        format: "YYYY-MM-DD"
        date_format: "YYYY-MM-DD"
        time_format: false
        required: true

      - label: "Draft"
        name: "draft"
        widget: "boolean"
        default: true
        required: false
        hint: "Set to false to publish"

      - label: "Tags"
        name: "tags"
        widget: "list"
        required: false
        hint: "Add relevant tags for categorization"

      - label: "Featured Image"
        name: "featured_image"
        widget: "image"
        required: false
        media_folder: "/static/images/posts/{{year}}/{{month}}"
        public_folder: "/images/posts/{{year}}/{{month}}"
        hint: "Main image displayed in post header"

      - label: "Gallery Images"
        name: "images"
        widget: "list"
        required: false
        field:
          label: "Image"
          name: "image"
          widget: "image"
          media_folder: "/static/images/posts/{{year}}/{{month}}"
          public_folder: "/images/posts/{{year}}/{{month}}"
        hint: "Additional images for gallery or content"

      - label: "Body"
        name: "body"
        widget: "markdown"
        required: true

  # ============================================
  # ARTICLES (Long-form Content)
  # ============================================
  - name: "articles"
    label: "Articles"
    label_singular: "Article"
    folder: "content/articles"
    create: true
    slug: "{{slug}}"
    preview_path: "articles/{{slug}}/"

    fields:
      - label: "Title"
        name: "title"
        widget: "string"
        required: true

      - label: "Publish Date"
        name: "date"
        widget: "datetime"
        format: "YYYY-MM-DD"
        date_format: "YYYY-MM-DD"
        time_format: false
        required: true

      - label: "Author"
        name: "author"
        widget: "string"
        required: false
        default: "Angelo Failla"

      - label: "Description"
        name: "description"
        widget: "text"
        required: false
        hint: "Brief summary for SEO and previews"

      - label: "Categories"
        name: "categories"
        widget: "list"
        required: false

      - label: "Tags"
        name: "tags"
        widget: "list"
        required: false

      - label: "Draft"
        name: "draft"
        widget: "boolean"
        default: true
        required: false

      - label: "Body"
        name: "body"
        widget: "markdown"
        required: true

  # ============================================
  # PROJECTS (Portfolio Items)
  # ============================================
  - name: "projects"
    label: "Projects"
    label_singular: "Project"
    folder: "content/projects"
    create: true
    slug: "{{slug}}"
    preview_path: "projects/{{slug}}/"

    fields:
      - label: "Title"
        name: "title"
        widget: "string"
        required: true

      - label: "Date"
        name: "date"
        widget: "datetime"
        format: "YYYY-MM-DD"
        date_format: "YYYY-MM-DD"
        time_format: false
        required: false
        hint: "Project start/completion date"

      - label: "Draft"
        name: "draft"
        widget: "boolean"
        default: true
        required: false

      - label: "Body"
        name: "body"
        widget: "markdown"
        required: true

  # ============================================
  # PUBLIC TALKS (Conference Presentations)
  # ============================================
  - name: "public-talks"
    label: "Public Talks"
    label_singular: "Public Talk"
    folder: "content/public-talks"
    create: true
    slug: "{{slug}}"
    preview_path: "public-talks/{{slug}}/"

    fields:
      - label: "Title"
        name: "title"
        widget: "string"
        required: true

      - label: "Date"
        name: "date"
        widget: "datetime"
        format: "YYYY-MM-DD"
        date_format: "YYYY-MM-DD"
        time_format: false
        required: true
        hint: "Talk presentation date"

      - label: "Layout"
        name: "layout"
        widget: "hidden"
        default: "single-public-talk"

      - label: "Body"
        name: "body"
        widget: "markdown"
        required: true

  # ============================================
  # PAGES (Static Pages: About, CV, etc.)
  # ============================================
  - name: "pages"
    label: "Pages"
    label_singular: "Page"
    folder: "content"
    filter: {field: "type", value: "page"}
    create: true
    slug: "{{slug}}"

    fields:
      - label: "Title"
        name: "title"
        widget: "string"
        required: true

      - label: "Type"
        name: "type"
        widget: "hidden"
        default: "page"

      - label: "Featured Image"
        name: "featured_image"
        widget: "image"
        required: false

      - label: "Images"
        name: "images"
        widget: "list"
        required: false
        field:
          label: "Image"
          name: "image"
          widget: "image"

      - label: "Body"
        name: "body"
        widget: "markdown"
        required: true
```

---

## GitHub OAuth Setup

### Detailed Steps for Option A (GitHub OAuth)

#### 1. Create GitHub OAuth App

1. Log into GitHub
2. Navigate to: **Settings** → **Developer settings** → **OAuth Apps**
3. Click **"New OAuth App"**

#### 2. Configure OAuth App

Fill in the form:

| Field | Value |
|-------|-------|
| Application name | `Hugo CMS - pallotron.net` |
| Homepage URL | `https://pallotron.net` (or your domain) |
| Application description | `Content management system for Hugo website` |
| Authorization callback URL | `https://api.netlify.com/auth/done` |

**Important:** Even though you're using Cloudflare Pages, use the Netlify callback URL. It's a standard OAuth flow handler.

#### 3. Save Credentials

After creating the app:

1. Copy the **Client ID**
2. Click **"Generate a new client secret"**
3. Copy the **Client Secret** (you won't see it again!)

**Store these securely** - you may need them for troubleshooting.

#### 4. Grant Repository Access

For the GitHub backend to work:

1. Go to your repository: `https://github.com/pallotron/site`
2. **Settings** → **Manage access**
3. Ensure OAuth app users have **Write** permissions
   - For yourself: automatic (you're the owner)
   - For others: Add them as collaborators

#### 5. Test Authentication

After deploying the CMS:

1. Visit `https://yoursite.com/admin/`
2. Click **"Login with GitHub"**
3. Authorize the OAuth app
4. You should be redirected to the CMS dashboard

**Troubleshooting:** If login fails, check:

- OAuth app callback URL is correct
- User has write access to repository
- No browser extensions blocking OAuth popup

---

## Testing Plan

### Pre-Deployment Testing (Local)

**Setup:**

```bash
# Terminal 1: Hugo server
hugo server -D

# Terminal 2: Decap proxy (for local auth)
npx decap-server
```

**Tests:**

| Test | Expected Result | Status |
|------|----------------|--------|
| Access `/admin/` | CMS loads without errors | [ ] |
| Login with local auth | Proxy authentication works | [ ] |
| View "Blog Posts" collection | Shows existing 10 posts | [ ] |
| View "Articles" collection | Shows existing 1 article | [ ] |
| View "Projects" collection | Shows existing 6 projects | [ ] |
| View "Public Talks" collection | Shows existing 4 talks | [ ] |
| View "Pages" collection | Shows about, cv pages | [ ] |
| Create new blog post | Draft appears in filesystem | [ ] |
| Add tags to post | YAML frontmatter updated | [ ] |
| Upload featured image | Image saved to correct path | [ ] |
| Preview markdown | Renders correctly | [ ] |
| Save draft | File created with `draft: true` | [ ] |
| Edit existing post | Changes saved correctly | [ ] |

---

### Post-Deployment Testing (Production)

**After pushing to Cloudflare Pages:**

| Test | Expected Result | Status |
|------|----------------|--------|
| Access `yoursite.com/admin/` | CMS loads | [ ] |
| GitHub OAuth login | Redirects to GitHub, then back to CMS | [ ] |
| View collections | All content visible | [ ] |
| Create draft post | Stays in draft state (no commit) | [ ] |
| Move to "In Review" | Creates new branch | [ ] |
| Check GitHub | PR created automatically | [ ] |
| Check Cloudflare | Preview deployment triggered | [ ] |
| Visit preview URL | See new post rendered | [ ] |
| Move to "Ready" | PR updated, ready to merge | [ ] |
| Click "Publish" | PR merges to main | [ ] |
| Check production site | Post appears live | [ ] |

---

### Editorial Workflow Testing

**Scenario:** Non-technical user creates a blog post

1. **User:** Logs into `/admin/`
2. **User:** Clicks "Blog Posts" → "New Blog Post"
3. **User:** Fills in:
   - Title: "Testing the new CMS"
   - Date: Today
   - Tags: ["test", "cms"]
   - Body: Some markdown content
4. **User:** Uploads a featured image
5. **User:** Clicks "Save"
   - **Expected:** Draft saved locally in CMS (no commit yet)
6. **User:** Clicks "Set status" → "In Review"
   - **Expected:**
     - Branch created: `cms/posts/testing-the-new-cms`
     - PR opened on GitHub
     - Cloudflare preview triggered
7. **Reviewer:** Gets notification (GitHub, email, Slack)
8. **Reviewer:** Clicks PR preview link from Cloudflare
9. **Reviewer:** Reviews rendered post
10. **Reviewer:** Approves PR in GitHub
11. **User:** Clicks "Set status" → "Ready"
12. **User:** Clicks "Publish"
    - **Expected:** PR merges to main, goes live

---

## Deployment

### Initial Deployment Checklist

- [ ] Create `static/admin/index.html`
- [ ] Create `static/admin/config.yml`
- [ ] Configure GitHub OAuth app
- [ ] Test locally with `npx decap-server`
- [ ] Commit CMS files to git
- [ ] Push to main branch
- [ ] Wait for Cloudflare Pages build
- [ ] Verify `/admin/` is accessible
- [ ] Test GitHub login
- [ ] Test creating draft content
- [ ] Test editorial workflow (PR creation)
- [ ] Test Cloudflare preview deployments
- [ ] Test publish workflow (PR merge)

### Git Commit Message Template

```text
Add Decap CMS for content management

- Add CMS interface at /admin/ with GitHub OAuth
- Configure editorial workflow with PR-based review
- Support for 5 content types:
  * Blog Posts (with date-based paths)
  * Articles (long-form evergreen content)
  * Projects (portfolio items)
  * Public Talks (conference presentations)
  * Pages (about, CV, static pages)
- Integrate with Cloudflare Pages preview deployments
- Enable non-technical users to create/edit content
- Maintain full git history and PR-based approval process

See docs/cms/ for implementation details.
```

---

## User Onboarding

### For Content Creators

**Quick Start Guide:**

1. **Access the CMS**
   - Go to `https://yoursite.com/admin/`
   - Click "Login with GitHub"
   - Authorize the app (first time only)

2. **Create a Blog Post**
   - Click "Blog Posts" in the left sidebar
   - Click "New Blog Post"
   - Fill in the title (required)
   - Set the publish date (defaults to today)
   - Add tags (optional)
   - Upload a featured image (optional)
   - Write your content in the markdown editor
   - Click "Save"

3. **Submit for Review**
   - Click the "Set status" dropdown at the top
   - Select "In Review"
   - This creates a pull request for the reviewer
   - You'll get a notification when it's approved

4. **Publish**
   - After approval, click "Set status" → "Ready"
   - Click "Publish" to make it live
   - Your post will appear on the site in ~2 minutes

**Markdown Tips:**

```markdown
# Heading 1
## Heading 2

**Bold text**
*Italic text*

- Bullet point
- Another point

1. Numbered list
2. Second item

[Link text](https://example.com)

![Image description](image-url)
```

**Image Uploads:**

- Click the image field to upload
- Supported formats: JPG, PNG, GIF, WebP
- Max size: 10MB recommended
- Images are stored alongside your post

---

### For Reviewers

**Review Workflow:**

1. **Get Notification**
   - GitHub email: "New pull request from CMS"
   - Or check: `https://github.com/pallotron/site/pulls`

2. **Review Content**
   - Click the PR link
   - Look for the Cloudflare Pages preview link in the PR checks
   - Click "View deployment" to see the rendered site
   - Review the post as it will appear live

3. **Approve or Request Changes**
   - **To approve:** Add approving review in GitHub
   - **To request changes:**
     - Comment on the PR with feedback
     - Content creator can edit in CMS
     - PR updates automatically

4. **Publish**
   - Content creator clicks "Publish" in CMS
   - PR auto-merges
   - Site rebuilds and goes live

**Review Checklist:**

- [ ] Title is clear and accurate
- [ ] Content is well-written and error-free
- [ ] Images display correctly
- [ ] Links work and point to correct pages
- [ ] Tags are appropriate
- [ ] Date is correct
- [ ] No sensitive information exposed

---

## Troubleshooting

### Common Issues

#### Issue: `/admin/` Returns 404

**Symptoms:** Cannot access the CMS interface

**Causes:**

1. Files not in correct location
2. Hugo build didn't include static files
3. Cloudflare cache

**Solutions:**

```bash
# Check files exist locally
ls -la static/admin/
# Should show: index.html, config.yml

# Rebuild Hugo locally
hugo --cleanDestinationDir
ls -la public/admin/
# Should show the same files

# If deployed, clear Cloudflare cache
# Or wait 5-10 minutes for cache to expire
```

---

#### Issue: "Config could not be loaded"

**Symptoms:** CMS loads but shows error about config.yml

**Causes:**

1. YAML syntax error in config.yml
2. File not accessible
3. Incorrect path in backend config

**Solutions:**

```bash
# Validate YAML syntax
npx js-yaml static/admin/config.yml

# Check for common errors:
# - Tabs instead of spaces (use spaces only)
# - Incorrect indentation
# - Missing quotes around strings with special chars
# - Invalid field names
```

---

#### Issue: GitHub Login Fails

**Symptoms:** OAuth popup closes without logging in

**Causes:**

1. OAuth app not configured
2. Incorrect callback URL
3. User lacks repo permissions
4. Browser blocking popup

**Solutions:**

1. Verify OAuth app settings:
   - Callback URL: `https://api.netlify.com/auth/done`
   - Application is active
2. Check user has write access to repo
3. Disable popup blockers
4. Try incognito/private window

---

#### Issue: "Not Found" When Creating Content

**Symptoms:** Can browse content but can't create new items

**Causes:**

1. User lacks write permissions
2. Branch protection rules blocking commits
3. Path template incorrect in config

**Solutions:**

1. Verify GitHub permissions:

   ```bash
   # Check if user is a collaborator
   gh api repos/pallotron/site/collaborators
   ```

1. Check branch protection on main:
   - Go to repo Settings → Branches
   - Ensure CMS can push to main (or configure to use different branch)

---

#### Issue: Images Not Uploading

**Symptoms:** Image upload button doesn't work or fails

**Causes:**

1. File too large
2. Unsupported format
3. Incorrect media_folder path
4. GitHub file size limits

**Solutions:**

1. Reduce image size (max 10MB recommended)
2. Use supported formats: JPG, PNG, GIF, WebP
3. Verify media_folder in config.yml points to `static/`
4. For very large images, use external hosting (Cloudinary, ImgIX)

---

#### Issue: Editorial Workflow Not Creating PRs

**Symptoms:** Moving to "In Review" doesn't create a pull request

**Causes:**

1. `publish_mode: editorial_workflow` not set
2. GitHub permissions insufficient
3. OAuth app needs broader permissions

**Solutions:**

1. Verify config.yml:

   ```yaml
   publish_mode: editorial_workflow
   ```

2. Check OAuth app has repo scope:
   - Settings → Developer settings → OAuth Apps → Your app
   - Check authorized scopes include "repo"
3. Reauthorize the app from CMS

---

#### Issue: Cloudflare Preview Not Appearing

**Symptoms:** PR created but no preview URL

**Causes:**

1. Cloudflare Pages not configured for PR previews
2. Branch name pattern not matching
3. Build failed

**Solutions:**

1. Check Cloudflare Pages settings:
   - Enable preview deployments
   - Preview branch pattern: `cms/*` or `*` (all branches)
2. Check build logs in Cloudflare dashboard
3. Verify Hugo build succeeds locally

---

### Debug Mode

Enable debug logging in the CMS:

**In `static/admin/index.html`:**

```html
<script>
  window.localStorage.setItem('decap-cms-debug', 'true');
</script>
<script src="https://unpkg.com/decap-cms@^3.0.0/dist/decap-cms.js"></script>
```

Check browser console for detailed error messages.

---

## Future Enhancements

### Phase 2 Features (After Initial Launch)

#### 1. Rich Media Gallery

**Problem:** Users upload many images but can't organize them
**Solution:** Integrate hugo-shortcode-gallery with CMS
**Effort:** 2-3 hours
**Benefit:** Better image management in posts

#### 2. Scheduled Publishing

**Problem:** Can't schedule posts for future dates
**Solution:** Use GitHub Actions to auto-merge PRs at scheduled time
**Effort:** 4-6 hours
**Benefit:** Content calendar management

#### 3. Custom Previews

**Problem:** CMS preview doesn't match actual site rendering
**Solution:** Configure custom preview templates
**Effort:** 3-4 hours
**Benefit:** WYSIWYG experience

#### 4. Bulk Operations

**Problem:** Can't update multiple posts at once
**Solution:** Add custom widget for batch editing tags/dates
**Effort:** 6-8 hours
**Benefit:** Faster content management

#### 5. Analytics Integration

**Problem:** No visibility into which posts are popular
**Solution:** Show page views in CMS (pull from Google Analytics API)
**Effort:** 8-10 hours
**Benefit:** Data-driven content decisions

---

### Phase 3 Features (Advanced)

#### 1. Multi-language Support

If expanding to multiple languages:

- Configure i18n in Hugo
- Add language selector in CMS
- Duplicate collections per language

**Effort:** 10-15 hours

#### 2. Custom Shortcodes UI

Create visual editors for:

- YouTube embeds
- PDF viewers
- Strava activities
- Photo galleries

**Effort:** 15-20 hours

#### 3. SEO Optimization

Add fields for:

- Meta descriptions
- Open Graph tags
- Twitter cards
- Schema.org markup

**Effort:** 5-7 hours

#### 4. Content Relationships

Link related content:

- "Related posts" picker
- Series/multi-part articles
- Project → blog post links

**Effort:** 8-12 hours

#### 5. Revision History

Visual diff viewer for changes:

- See what changed between versions
- Restore previous versions
- Compare drafts

**Effort:** 12-16 hours

---

## Maintenance Plan

### Monthly Tasks

- [ ] Check for Decap CMS updates
- [ ] Review and close stale draft PRs
- [ ] Update OAuth app if credentials expire
- [ ] Review CMS access logs (GitHub audit)

### Quarterly Tasks

- [ ] Survey content creators for feedback
- [ ] Analyze usage patterns (which content types most used)
- [ ] Consider adding requested features
- [ ] Review and update user documentation

### Annual Tasks

- [ ] Full security audit of OAuth setup
- [ ] Evaluate alternative CMS solutions (if needs change)
- [ ] Review content organization (taxonomy, structure)

---

## Success Criteria

### Metrics to Track

**Adoption:**

- [ ] Number of users actively using CMS
- [ ] Posts created via CMS vs. directly in git
- [ ] Time from draft to published (should be < 1 day)

**Quality:**

- [ ] PRs requiring revision (target: < 20%)
- [ ] Broken images/links (target: 0)
- [ ] Frontmatter errors (target: 0)

**Performance:**

- [ ] CMS load time (target: < 2 seconds)
- [ ] Image upload success rate (target: > 95%)
- [ ] PR creation success rate (target: 100%)

**User Satisfaction:**

- [ ] Content creator survey score (target: 8+/10)
- [ ] Support tickets/questions (target: < 1 per month after onboarding)

---

## Rollback Plan

If Decap CMS doesn't work out:

### Immediate Rollback

```bash
# Remove CMS files
git rm -r static/admin/
git commit -m "Remove Decap CMS"
git push origin main
```

**Impact:** None on content (all posts remain in git)

### Migration Path

If switching to different CMS:

1. Content stays in git (markdown + frontmatter)
2. Only need to reconfigure new CMS to read same files
3. No content migration needed

**Why this is low-risk:**

- Content is not locked into Decap CMS format
- Standard Hugo markdown files
- Git history preserved
- Can always edit files directly in GitHub

---

## Support Resources

### Documentation

- **Decap CMS Docs:** <https://decapcms.org/docs/>
- **Hugo Docs:** <https://gohugo.io/documentation/>
- **This Implementation:** `/docs/cms/`

### Community

- **Decap CMS Discussions:** <https://github.com/decaporg/decap-cms/discussions>
- **Hugo Forum:** <https://discourse.gohugo.io/>

### Internal

- **Site Analysis:** `/docs/cms/analysis/`
- **Discussion Summary:** `/docs/cms/planning/discussion-summary.md`
- **This Plan:** `/docs/cms/planning/implementation-plan.md`

### Getting Help

1. Check troubleshooting section above
2. Search Decap CMS GitHub issues
3. Ask in Hugo forum
4. Open issue in site repo

---

## Appendix: Configuration Reference

### Widget Types Available

Common Decap CMS widgets for your content:

| Widget | Use Case | Example |
|--------|----------|---------|
| `string` | Short text (titles) | `title: "My Post"` |
| `text` | Multi-line text | `description: "A brief summary"` |
| `markdown` | Rich content | `body: "# Heading\n\nParagraph"` |
| `boolean` | True/false | `draft: true` |
| `datetime` | Dates/times | `date: 2025-11-04` |
| `image` | File uploads | `featured_image: /img/photo.jpg` |
| `list` | Arrays | `tags: [tag1, tag2]` |
| `select` | Dropdown | `category: tech` |
| `hidden` | Auto-filled | `type: page` |

### Path Templates

Variables available in `path` and `slug`:

| Variable | Example | Description |
|----------|---------|-------------|
| `{{slug}}` | `my-post` | URL-friendly title |
| `{{year}}` | `2025` | 4-digit year |
| `{{month}}` | `11` | 2-digit month |
| `{{day}}` | `04` | 2-digit day |
| `{{hour}}` | `14` | 2-digit hour |
| `{{minute}}` | `30` | 2-digit minute |
| `{{fields.title}}` | `My Post` | Any field value |

### Frontmatter Formats

Decap CMS supports both, defaults to YAML:

**YAML (recommended):**

```yaml
---
title: "My Post"
date: 2025-11-04
tags: [tech, tutorial]
---
```

**TOML (legacy):**

```toml
+++
title = "My Post"
date = 2025-11-04
tags = ["tech", "tutorial"]
+++
```

---

**Document Status:** Complete and ready for implementation
**Next Step:** Begin setup with Step 1 (create directory structure)
**Estimated Time to Production:** 1-2 hours

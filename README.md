<img src="https://raw.githubusercontent.com/matt-dray/stickers/master/output/rostrum_hex.png" alt="Hexagonal sticker with the Rostrum logo on it" width="150" align="right">

# rostrum-blog

[![Netlify Status](https://api.netlify.com/api/v1/badges/ebfbdae4-a903-43e8-9f53-75becd95b42e/deploy-status)](https://app.netlify.com/sites/rostrum/deploys)

## What?

Hello and welcome to the source files for [rostrum.blog](https://www.rostrum.blog/) by [Matt](https://www.twitter.com/mattdray) and [Adriana](https://twitter.com/adpalma). Learn more about the blog on the [About](https://www.rostrum.blog/about/) page.

## Site construction

The site was generated with the [blogdown](https://bookdown.org/yihui/blogdown/) package from the mighty [Yihui Xie](https://yihui.name/en/).

We used the Hugo Lithium Theme forked from [\@jrutheiser/hugo-lithium-theme](https://github.com/jrutheiser/hugo-lithium-theme) and modified by the legendary [Yihui Xie](https://github.com/yihui/hugo-lithium-theme).

The site is hosted with [Netlify](https://www.netlify.com/).

## For authors

### Process

1. From the terminal: `git clone https://github.com/matt-dray/rostrum-blog.git`
2. Open `rostrum-blog.Rproj` in RStudio
3. Start a new branch with `git branch new/post-slug` from the RStudio terminal (where `post-slug` is the expected short-name that will go in the URL) and `git checkout new/post-slug` to move the `HEAD` to this branch
4. Go to Addins > New Post in RStudio (assumes `blogdown` is installed)
5. In the pop-up, complete the title, author, categories and tags (choose from existing ones where possible; the Lithium theme doesn't yet have support for displaying tags and categories in their own pages, but fill this in anyway because we might sort it out in future) and select the 'R Markdown (.Rmd)' radio button
7. Write your post (for images, go to Addins > Add image)
10. Go to Addins > Serve site and the site while render to the viewer (view in-browser with the 'Show in new window' button in the viewer menu)
9. `git commit` and `git push` to `new/post-slug` as required when drafting the post
11. Perform a pull request

### Simple process

Don't create a separate branch. Just add `draft: yes` to the YAML of your post. You can serve site and push commits without this post going live. When ready, change the YAML to `draft: no` and it will go live when the site is served, committed and pushed.

### Theory

* New .Rmd posts are added to content > post
* Serving the site renders the .html and adds static files (images) to static > post
* Pushing to GitHub triggers Netlify to recognise the changes and render the site

_Adapted from [fastai/nbdev/CONTRIBUTING.md](https://github.com/fastai/nbdev/blob/master/CONTRIBUTING.md)_

# How to contribute to fastpages

First, thanks a lot for wanting to help! Some things to keep in mind:

- The jupyter to blog post conversion functionality relies on [fastai/nbdev](https://github.com/fastai/nbdev).  For idiosyncratic uses of nbdev that only apply to blogs that would require a large refactor to nbdev, it might be acceptable to apply a [monkey patch](https://stackoverflow.com/questions/5626193/what-is-monkey-patching) in `fastpages`.  However, it is encouraged to contribute to `nbdev` where possible if there is a change that could unlock a new feature.  If you are unsure, please open an issue in this repo to discucss.


## Note for new contributors from Jeremy

It can be tempting to jump into a new project by questioning the stylistic decisions that have been made, such as naming, formatting, and so forth. This can be especially so for python programmers contributing to this project, which is unusual in following a number of conventions that are common in other programming communities, but not in Python. However, please don’t do this, for (amongst others) the following reasons:

- Contributing to [Parkinson’s law of triviality](https://www.wikiwand.com/en/Law_of_triviality) has negative consequences for a project. Let’s focus on deep learning!
- It’s exhausting to repeat the same discussion over and over again, especially when it’s been well documented already. When you have a question about the project, please check the pages in the docs website linked here.
- You’re likely to get a warmer welcome from the community if you start out by contributing something that’s been requested on the forum, since you’ll be solving someone’s current problem.
- If you start out by just telling us your point of view, rather than studying the background behind the decisions that have been made, you’re unlikely to be contributing anything new or useful.
- I’ve been writing code for nearly 40 years now, across dozens of languages, and other folks involved have quite a bit of experience too - the approaches used are based on significant experience and research. Whilst there’s always room for improvement, it’s much more likely you’ll be making a positive contribution if you spend a few weeks studying and working within the current framework before suggesting wholesale changes.


## Did you find a bug?

* Nobody is perfect, especially not us. But first, please double-check the bug doesn't come from something on your side. The [forum](http://forums.fast.ai/) is a tremendous source for help, and we'd advise to use it as a first step. Be sure to include as much code as you can so that other people can easily help you.
* Then, ensure the bug was not already reported by searching on GitHub under [Issues](https://github.com/fastai/fastpages/issues).
* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/fastai/fastpages/issues/new). Be sure to include a title and clear description, as much relevant information as possible, and a code sample or an executable test case demonstrating the expected behavior that is not occurring.
* Be sure to add the complete error messages.

#### Did you write a patch that fixes a bug?

* Open a new GitHub pull request with the patch.
* Ensure that your PR includes a test that fails without your patch, and pass with it.
* Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable.
* Before submitting, please be sure you abide by our [coding style](https://docs.fast.ai/dev/style.html) (where appropriate) and [the guide on abbreviations](https://docs.fast.ai/dev/abbr.html) and clean-up your code accordingly.

## Do you intend to add a new feature or change an existing one?

* You can suggest your change on the [fastai forum](http://forums.fast.ai/) to see if others are interested or want to help. 
* Once your approach has been discussed and confirmed on the forum, you are welcome to push a PR, including a complete description of the new feature and an example of how it's used. Be sure to document your code in the notabook.
* Ensure that your code includes tests that exercise not only your feature, but also any other code that might be impacted.

## PR submission guidelines

Some general rules of thumb that will make your life easier.

* Test locally before opening a pull request. See [the development guide](_fastpages_docs/DEVELOPMENT.md) for instructions on how to run fastpages on your local machine.
* When you do open a pull request, please request a draft build of your PR by making a **comment with the magic command `/preview` in the pull request.**  This will allow reviewers to see a live-preview of your changes without having to clone your branch.
    * You can do this multiple times, if necessary, to rebuild your preview due to changes.  But please do not abuse this and test locally before doing this.

* Keep each PR focused. While it's more convenient, do not combine several unrelated fixes together. Create as many branches as needing to keep each PR focused.
* Do not mix style changes/fixes with "functional" changes. It's very difficult to review such PRs and it most likely get rejected.
* Do not add/remove vertical whitespace. Preserve the original style of the file you edit as much as you can.
* Do not turn an already submitted PR into your development playground. If after you submitted PR, you discovered that more work is needed - close the PR, do the required work and then submit a new PR. Otherwise each of your commits requires attention from maintainers of the project.
* If, however, you submitted a PR and received a request for changes, you should proceed with commits inside that PR, so that the maintainer can see the incremental fixes and won't need to review the whole PR again. In the exception case where you realize it'll take many many commits to complete the requests, then it's probably best to close the PR, do the work and then submit it again. Use common sense where you'd choose one way over another.
* When you open a pull request, you can generate a live preview build of how the blog site will look by making a comment in the PR that contains this command: `/preview`.  GitHub will build your site and drop a temporary link for everyone to review.  You can do this as multiple times if necessary, however as mentioned previously do not turn an already submitted  PR inot a development playground.

## Do you have questions about the source code?

* Please ask it on the [fastai forum](http://forums.fast.ai/) (after searching someone didn't ask the same one before with a quick search). We'd rather have the maximum of discussions there so that the largest number can benefit from it.

## Do you want to contribute to the documentation?

* PRs are welcome for this.  For any confusion about the documentation, please feel free to open an issue on this repo.


# Description
An opinionated configuration layer and development environment centred around the GNU Emacs editor. Includes builtin support for LaTeX, Python, and Octave. Accessible via a Dockerfile which must be run with a bind mount to the user's home directory. Additionally includes prototypical Elisp code which may eventually be split into separate modular packages (such as [Photon Modeline](https://github.com/seb-hyland/photon-modeline)).

# Purpose
- Personal, daily-driver development environment
- Learn functional programming via Emacs Lisp
- Learn Docker build manifests
- Better understand Unix systems by using a slim base distribution (Alpine Linux)

Note: this is not *yet* ready for distribution. You may attempt to build the Dockerfile at your own risk. It is recommended you read the [primary Emacs configuration](./config.org) first, as it interacts with directories in the user's home folder.

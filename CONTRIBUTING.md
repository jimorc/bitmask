# How to Contribute to this Project

Thank you for investing your time in contributing to this project.

Read the [GitHub docs Code of Conduct](https://github.com/github/docs/blob/main/CODE_OF_CONDUCT.md).
While this code of conduct seems
excessive for a project of the size of the bitmask repository, it will
illustrate how to keep this community approachable and respectable.

This guide will provide you with an overview of the contribution workflow
from opening an issue, creating a PR, reviewing, and merging the PR.

## New contributor guide

To get an overview of the project, read the [README](README.md) file. Here
are some resources to help you get started with open source contributions
in general:

* [Finding ways to contribute to open source on GitHb](https://docs.github.com/en/get-started/exploring-projects-on-github/finding-ways-to-contribute-to-open-source-on-github)
* [Set up Git](https://docs.github.com/en/get-started/quickstart/set-up-git)
* [GitHub flow](https://docs.github.com/en/get-started/quickstart/github-flow)
* [Collaborating with pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests)

## Getting Started

Check to see what types of contributions we accept before making changes.
Some of them do not even require writing a single line of code.

### Issues

#### Create a new issue

If you spot a problem with the code, search if an issue already exists. If
a related issue doesn't exist, you can open a new issue using the relevant
[issue form](https://github.com/jimorc/bitmask.issues/new/choose).

#### Solve an issue

Scan through the [existing issues](https://github.com/jimorc/issues) to
find one that interests you. You can narrow down the search using
`labels` as filters. If you see an issue that is not assigned to anyone,
you are welcome to open a PR to fix it.

### Make Changes

#### Make Changes in the Documentation

These changes can be as small as fixing a typo, a sentence, or a broken
link. Create a pull request for review of your changes.

#### Make Changes in the Code Locally

1. Fork the repository so that you can make your changes without affecting
the original project until you are ready to merge them.
2. Create a working branch and start your changes.
3. Be sure to update the documentation as needed.

### Commit your update

Perform a self review to speed up the review process.
Commit the changes once you are happy with them.

#### Self review

1. Did you make changes to existing constructors, methods, or properties?
If so, did you:

    * Make required changes to existing tests, or add new tests.
    * Run all tests:

    ```bash
    dart test
    ```

    * Add code to `example/bitmask_example.dart` to show how to use
    your new functionality if necessary?
    * Execute the example program and check that the output is correct?

    ```bash
    dart run example/bitmask_example.dart
    ```

2. Did you add new constructors, methods, or properties? If so, did you:

    * Add code to `example/bitmask_example.dart` to show how to use
    your new functionality?
    * Execute the example program and check that the output is correct?

    ```bash
    dart run example/bitmask_example.dart
    ```

    * Add new tests to cover the new code that you added?
    * Run all tests and check for 100% coverage. `bitmask` is a simple
    library, so 100% coverage should be easy to obtain.
    If you do not have
    100% coverage, you must have very good reason for this.

    ```bash
    dart test --coverage
    genhtml coverage/lcov.info -o coverage/html
    open coverage/html/index.html
    ```

3. Did you update the documentation to reflect your changes?

    * Generate and then review the documentation.

    ```bash
    dart doc
    open doc/api/index.html
    ```

4. Did you format the code to follow
[Dart guidelines](https://dart.dev/effective-dart/style#formatting)? If
you used a IDE with Dart or Flutter plugins, then the IDE probably
formated the code for you. If not:

```bash
dart format lib example
```

### Pull Request

When you are finished with the changes, please create a pull request.

* Don't forget to link the PR to an issue if you are solving one. If there
is no existing issue, we would prefer that you create an issue to tie the
PR to.
* Once you submit your PR, a bitmask team member will review your proposal.
We may ask questions or request additional information.
* We may ask for changes to be made before the PR can be merged, either
using suggested changes or pull request comments. You can apply suggested changes and other changes directly in your fork, then commit them to your
branch.
* As you update your PR and apply changes, mark each conversation as
[resolved](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/commenting-on-a-pull-request#resolving-conversations).
* If you run into any merge issues, checkout this
[git tutorial](https://github.com/skills/resolve-merge-conflicts)
to help you resolve merge conflicts and other issues.

### Your PR is merged

Congratulations. The bitmask team thanks you.

Once your PR is merged, your contributions will be publicly visible in the
bitmask repository.

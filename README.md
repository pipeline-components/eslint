# Pipeline Components: Deployer

[![][gitlab-repo-shield]][repository]
![Project Stage][project-stage-shield]
![Project Maintenance][maintenance-shield]
[![License][license-shield]](LICENSE)
[![GitLab CI][gitlabci-shield]][gitlabci]

## Docker status

[![Image Size][size-shield]][dockerhub]
[![Docker Pulls][pulls-shield]][dockerhub]

## Usage

The image is for running [ESLint][eslint]. ESLint is installed in /app/ in case you need to customize the install before usage.

## Examples

### Basic Integration

This integration runs as a pipeline job. If any issues are found that are not
silenced by the configuration, the job (and pipeline) fails.

```yaml
eslint:
  needs: []
  image: registry.gitlab.com/pipeline-components/eslint:latest
  before_script:
    - touch dummy.js
  script:
    - eslint --color .
```

Notes:

* Touching dummy.js prevents ESLint from complaining that it had no files
  to lint.
* If you don't want to customize the rules that are used, add
  `--no-config-lookup` to the commandline.

### GitLab Code Quality Integration

This integration runs as a pipeline job, too. Other than the simple
integration above, it doesn't fail the job if any issues are found.
Instead, it makes all issues available via GitLab's
[Code Quality][gitlab-code-quality]
feature. That will display the changes in the set of found issues inside
the Merge Request view, to support in code reviews before merging.

```yaml
eslint:
  artifacts:
    reports:
      codequality: gl-codequality.json
  image: registry.gitlab.com/pipeline-components/eslint:latest
  needs: []
  script:
    # ESLint exits with 1 in case it finds any issues, which is not an
    # error in the context of the pipeline. If it encounters an internal
    # problem, it exits with 2 instead.
    - eslint --format gitlab . || [ $? == 1 ]
```

Notes:

* If you don't want to customize the rules that are used, add
  `--no-config-lookup` to the commandline.
* In a merge request, GitLab gives you the delta between the issues in
  your branch and the target branch. Initially, when integrating in this
  way, the issues found for the target branch are empty, giving you a
  potentially _very_ long list. Only on subsequent merge request you get
  a delta that actually related to the changes in that merge request.
* In a typical setup, you don't configure ESLint to ignore issues it
  detects that you don't care about. Instead, you rely on a code review
  by a second developer, supported by the info provided by GitLab.

## Versioning

This project uses [Semantic Versioning][semver] for its version numbering.

## Support

Got questions?

Check the [discord channel][discord]

You could also [open an issue here][issue]

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

We've set up a separate document for our [contribution guidelines][contributing-link].

Thank you for being involved! 😍

## Authors & contributors

The original setup of this repository is by [Robbert Müller][mjrider].

The Build pipeline is large based on [Community Hass.io Add-ons
][hassio-addons] by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

This project is licensed under the [MIT License](./LICENSE) by [Robbert Müller][mjrider].

[contributing-link]: https://pipeline-components.dev/contributing/
[contributors]: https://gitlab.com/pipeline-components/eslint/-/graphs/main
[discord]: https://discord.gg/vhxWFfP
[dockerhub]: https://hub.docker.com/r/pipelinecomponents/eslint
[frenck]: https://github.com/frenck
[gitlab-repo-shield]: https://img.shields.io/badge/Source-Gitlab-orange.svg?logo=gitlab
[gitlabci-shield]: https://img.shields.io/gitlab/pipeline/pipeline-components/eslint.svg
[gitlabci]: https://gitlab.com/pipeline-components/eslint/-/commits/main
[hassio-addons]: https://github.com/hassio-addons
[issue]: https://gitlab.com/pipeline-components/eslint/issues
[license-shield]: https://img.shields.io/badge/License-MIT-green.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2025.svg
[mjrider]: https://gitlab.com/mjrider
[project-stage-shield]: https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg
[pulls-shield]: https://img.shields.io/docker/pulls/pipelinecomponents/eslint.svg?logo=docker
[repository]: https://gitlab.com/pipeline-components/eslint
[semver]: http://semver.org/spec/v2.0.0.html
[size-shield]: https://img.shields.io/docker/image-size/pipelinecomponents/eslint.svg?logo=docker

[eslint]: https://eslint.org/
[gitlab-code-quality]: https://docs.gitlab.com/ee/ci/testing/code_quality.html

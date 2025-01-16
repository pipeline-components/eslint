# Pipeline Components: Deployer

![Project Stage][project-stage-shield]
![Project Maintenance][maintenance-shield]
[![License][license-shield]](LICENSE)

[![GitLab CI][gitlabci-shield]][gitlabci]

## Docker status

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

We've set up a separate document for our [contribution guidelines](CONTRIBUTING.md).

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [Robbert Müller][mjrider].

The Build pipeline is large based on [Community Hass.io Add-ons
][hassio-addons] by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License

Copyright (c) 2018 Robbert Müller

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[commits]: https://gitlab.com/pipeline-components/eslint/-/commits/master
[contributors]: https://gitlab.com/pipeline-components/eslint/-/graphs/master
[dockerhub]: https://hub.docker.com/r/pipelinecomponents/eslint
[license-shield]: https://img.shields.io/badge/License-MIT-green.svg
[mjrider]: https://gitlab.com/mjrider
[discord]: https://discord.gg/vhxWFfP
[gitlabci-shield]: https://img.shields.io/gitlab/pipeline/pipeline-components/eslint.svg
[gitlabci]: https://gitlab.com/pipeline-components/eslint/-/commits/master
[gitlab-code-quality]: https://docs.gitlab.com/ee/ci/testing/code_quality.html
[issue]: https://gitlab.com/pipeline-components/eslint/issues
[keepchangelog]: http://keepachangelog.com/en/1.0.0/
[maintenance-shield]: https://img.shields.io/maintenance/yes/2025.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg
[pulls-shield]: https://img.shields.io/docker/pulls/pipelinecomponents/eslint.svg
[releases]: https://gitlab.com/pipeline-components/eslint/tags
[repository]: https://gitlab.com/pipeline-components/repository
[semver]: http://semver.org/spec/v2.0.0.html
[eslint]: https://eslint.org/

[frenck]: https://github.com/frenck
[hassio-addons]: https://github.com/hassio-addons

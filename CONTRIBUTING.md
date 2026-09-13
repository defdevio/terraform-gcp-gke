# Contributing

## Local checks

Install OpenTofu 1.11.4 or newer, Go 1.26.0 or newer, `terraform-docs`, `actionlint`, and `pre-commit`. Enable the hooks before making changes:

```sh
pre-commit install
pre-commit run --all-files
```

Run the module checks directly when iterating:

```sh
tofu fmt -check
tofu init -backend=false
tofu validate
tofu plan
cd test
go test ./...
```

The default Terratest suite is plan-only. Add live integration tests only in a dedicated workflow with explicit provider credentials.

## Derived modules

Clone this repository and replace every template placeholder before the first release:

- repository metadata, module title, source URL, and description
- the provider source, provider name, and version constraint in `versions.tf`
- module inputs in `variables.tf`
- implementation in `main.tf`
- stable consumer outputs in `outputs.tf`
- the README usage example and generated Terraform reference
- plan inputs and resource or relationship assertions in `test/module_test.go`

Do not edit the generated README section between `BEGIN_TF_DOCS` and `END_TF_DOCS` manually. Run `terraform-docs` to update it.

## Commits and releases

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` creates a minor release
- `fix:` creates a patch release
- `feat!:` or `fix!:` creates a major release
- `chore:` does not create a release

Releases are created automatically from conventional commits merged into `main`.

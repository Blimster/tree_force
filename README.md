# Tree Force
A web ui framework based on a widget tree inspired by Flutter.

## Experimental

This package is in a proof-of-concept phase and is highly experimental. There is a good chance
that the API will break with a new version of the package. Furthermore, don't expect high quality yet.

## Roadmap

- Replace AngularDart in an internal use case (required features: some layout, images, text inputs, buttons, router, forms)
- Optimize widget tree rebuild (currently the complete widget tree is rebuild even in the case a single leave has a state change)
- Introduce keys for widgets in lists
- Evaluate an in-code alternative for CSS
- Implement more widgets
- Tests
- Documentation
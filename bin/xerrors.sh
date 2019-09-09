#!/bin/sh
sed -i -e '/"github.com\/pkg\/errors"/ s,"github.com/pkg/errors",errors "golang.org/x/xerrors",;
	/errors.Wrap(/ s/errors.Wrap(\([^,]*\), \([^ ][^)]*\))\()*\)$/errors.Errorf("%s: %w", \2, \1)\3/;
	/errors.WithMessage(/ s/errors.WithMessage(\([^,]*\), \(.*\))$/errors.Errorf("%s: %w", \2, \1)/;
	/errors.Wrapf(/ s/errors.Wrapf(\([^,]*\), "\([^"]*\)",\(.*\))$/errors.Errorf("\2: %w", \3,\1)/' \
	$(find . -type f -name '*.go')
vi $(grep -Fl errors $(find . -type f -name '*.go'))

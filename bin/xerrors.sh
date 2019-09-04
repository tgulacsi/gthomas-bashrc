#!/bin/sh
sed -i -e '/"github.com\/pkg\/errors"/ s,"github.com/pkg/errors",errors "golang.org/x/xerrors",; /errors.Wrap(/ s/errors.Wrap(\([^,]*\), \([^ ][^)]*\))\()*\)$/errors.Errorf("%s: %w", \2, \1)\3/; /errors.Wrapf(/ s/errors.Wrapf(\([^,]*\), "\([^"]*\)",\(.*\))$/errors.Errorf("\2: %w", \1,\3)/' $(find . -type f -name '*.go')

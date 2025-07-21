#!/bin/sh

set -eu

DIRNAME=$(readlink -f "$(dirname "$0")")

: ${DEVELOPER:=/opt/kx/developer}

WORKSPACE=funds_capstone

[ "${1:-}" != update ] || exit 0

for F in .gitremote.google .authorized_keys; do
	test ! -f "$DIRNAME/$F" || git -C "$DIRNAME" rm --quiet "$F"
done
git -C "$DIRNAME" commit --quiet -a -m 'trim bits not needed by students' || true

exec /bin/sh "$DEVELOPER/packageWorkspace.sh" $WORKSPACE "$DIRNAME" main $WORKSPACE

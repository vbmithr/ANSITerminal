if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    brew update
    brew install ocaml opam
fi

OPAM_PKGS="jbuilder base-bytes"

export OPAMYES=1

if [ -f "$HOME/.opam/config" ]; then
    opam update
    opam upgrade
else
    opam init
fi

if [ -n "${OPAM_SWITCH}" ]; then
    opam switch ${OPAM_SWITCH}
fi
eval `opam config env`

opam install $OPAM_PKGS

export OCAMLRUNPARAM=b
make all

echo "-=-=- Tests -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
#make test
#jbuilder exec tests/showcolors.exe
_build/default/tests/showcolors.exe

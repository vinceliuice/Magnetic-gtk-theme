#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

png_main() {
  local color="${1}"
  local screen="${2}"

  local SRC_FILE="assets-${type}${color}.svg"
  local ASSETS_DIR="${type}/assets${color}${screen}"

  case "${screen}" in
    -hdpi)
      DPI='144'
      ;;
    -xhdpi)
      DPI='192'
      ;;
    *)
      DPI='96'
      ;;
  esac

  mkdir -p "$ASSETS_DIR"

  if [[ -f "$ASSETS_DIR/$i.png" ]]; then
    echo -e "$ASSETS_DIR/$i.png exists."
  else
    echo
    echo -e "Rendering $ASSETS_DIR/$i.png"
    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-dpi=$DPI \
              --export-filename=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
    $OPTIPNG -o7 --quiet "$ASSETS_DIR/$i.png"
  fi

  (
  cd $ASSETS_DIR
  ln -sf title-active.png title-1-active.png
  ln -sf title-active.png title-2-active.png
  ln -sf title-active.png title-3-active.png
  ln -sf title-active.png title-4-active.png
  ln -sf title-active.png title-5-active.png
  ln -sf title-inactive.png title-1-inactive.png
  ln -sf title-inactive.png title-2-inactive.png
  ln -sf title-inactive.png title-3-inactive.png
  ln -sf title-inactive.png title-4-inactive.png
  ln -sf title-inactive.png title-5-inactive.png
  )
}

xpm_main() {
  local screen="${1}"

  local SRC_FILE="assets-${type}.svg"
  local ASSETS_DIR="${type}/assets${screen}"

  case "${screen}" in
    -hdpi)
      DPI='144'
      ;;
    -xhdpi)
      DPI='192'
      ;;
    *)
      DPI='96'
      ;;
  esac

  mkdir -p "$ASSETS_DIR"

  if [[ -f "$ASSETS_DIR/$i.xpm" ]]; then
    echo -e "$ASSETS_DIR/$i.xpm exists."
  else
    echo
    echo -e "Rendering $ASSETS_DIR/$i.png"
    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-dpi=$DPI \
              --export-filename=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
    convert "$ASSETS_DIR/$i.png" "$ASSETS_DIR/$i.xpm"
    sed -i "s/c #3A3D41/c #3A3D41 s active_color_2/g" "$ASSETS_DIR/$i.xpm"
    sed -i "s/c #44474B/c #44474B s inactive_color_2/g" "$ASSETS_DIR/$i.xpm"
    rm -rf $ASSETS_DIR/$i.png
  fi

  (
  cd $ASSETS_DIR
  ln -sf button-active.xpm close-active.xpm
  ln -sf button-active.xpm close-prelight.xpm
  ln -sf button-active.xpm close-pressed.xpm
  ln -sf button-inactive.xpm close-inactive.xpm
  ln -sf button-active.xpm hide-active.xpm
  ln -sf button-active.xpm hide-prelight.xpm
  ln -sf button-active.xpm hide-pressed.xpm
  ln -sf button-inactive.xpm hide-inactive.xpm
  ln -sf button-active.xpm maximize-active.xpm
  ln -sf button-active.xpm maximize-prelight.xpm
  ln -sf button-active.xpm maximize-pressed.xpm
  ln -sf button-inactive.xpm maximize-inactive.xpm
  ln -sf button-active.xpm maximize-toggled-active.xpm
  ln -sf button-active.xpm maximize-toggled-prelight.xpm
  ln -sf button-active.xpm maximize-toggled-pressed.xpm
  ln -sf button-inactive.xpm maximize-toggled-inactive.xpm
  ln -sf button-active.xpm shade-active.xpm
  ln -sf button-active.xpm shade-prelight.xpm
  ln -sf button-active.xpm shade-pressed.xpm
  ln -sf button-inactive.xpm shade-inactive.xpm
  ln -sf button-active.xpm shade-toggled-active.xpm
  ln -sf button-active.xpm shade-toggled-prelight.xpm
  ln -sf button-active.xpm shade-toggled-pressed.xpm
  ln -sf button-inactive.xpm shade-toggled-inactive.xpm
  ln -sf button-active.xpm stick-active.xpm
  ln -sf button-active.xpm stick-prelight.xpm
  ln -sf button-active.xpm stick-pressed.xpm
  ln -sf button-inactive.xpm stick-inactive.xpm
  ln -sf button-active.xpm stick-toggled-active.xpm
  ln -sf button-active.xpm stick-toggled-prelight.xpm
  ln -sf button-active.xpm stick-toggled-pressed.xpm
  ln -sf button-inactive.xpm stick-toggled-inactive.xpm
  ln -sf button-active.xpm menu-active.xpm
  ln -sf button-active.xpm menu-prelight.xpm
  ln -sf button-active.xpm menu-pressed.xpm
  ln -sf button-inactive.xpm menu-inactive.xpm
  ln -sf title-active.xpm title-1-active.xpm
  ln -sf title-active.xpm title-2-active.xpm
  ln -sf title-active.xpm title-3-active.xpm
  ln -sf title-active.xpm title-4-active.xpm
  ln -sf title-active.xpm title-5-active.xpm
  ln -sf title-inactive.xpm title-1-inactive.xpm
  ln -sf title-inactive.xpm title-2-inactive.xpm
  ln -sf title-inactive.xpm title-3-inactive.xpm
  ln -sf title-inactive.xpm title-4-inactive.xpm
  ln -sf title-inactive.xpm title-5-inactive.xpm
  )
}

make_png() {
  local type="png"
  local INDEX="assets-${type}.txt"

  for i in `cat $INDEX`; do
    for color in '' '-Dark'; do
      for screen in '' '-hdpi' '-xhdpi'; do
        png_main "${color}" "${screen}"
      done
    done
  done
}

make_xpm() {
  local type="xpm"
  local INDEX="assets-${type}.txt"

  for i in `cat $INDEX`; do
    for screen in '' '-hdpi' '-xhdpi'; do
      xpm_main "${screen}"
    done
  done
}

make_png && make_xpm


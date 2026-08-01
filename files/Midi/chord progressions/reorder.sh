#!/bin/bash

for dir in * ; do
  if [ -d "$dir" ]; then
    echo "Reordering styles in $dir..."
    cd "$dir"
	mv "hiphop2 style" "hiphop"
	mv "pop style" "pop"
	mv "pop2 style" "pop2"
	mv "soul style" "soul"
	mkdir plain
	mv *.mid plain
	for subdir in * ; do
		if [ -d "$subdir" ]; then
			echo "Reordering chords in $subdir..."
			cd "$subdir"
			if [[ "$dir" == "Minor" ]]; then
				mkdir A
				mv A\ -* A
				mkdir B
				mv B\ -* B
				mkdir Bb
				mv Bb\ -* Bb
				mkdir C
				mv C\ -* C
				mkdir C#
				mv C#\ -* C#
				mkdir D
				mv D\ -* D
				mkdir E
				mv E\ -* E
				mkdir Eb
				mv Eb\ -* Eb
				mkdir F
				mv F\ -* F
				mkdir F#
				mv F#\ -* F#
				mkdir G
				mv G\ -* G
				mkdir G#
				mv G#\ -* G#
			else
				mkdir A
				mv A\ -* A
				mkdir Ab
				mv Ab\ -* Ab
				mkdir B
				mv B\ -* B
				mkdir Bb
				mv Bb\ -* Bb
				mkdir C
				mv C\ -* C
				mkdir D
				mv D\ -* D
				mkdir Db
				mv Db\ -* Db
				mkdir E
				mv E\ -* E
				mkdir Eb
				mv Eb\ -* Eb
				mkdir F
				mv F\ -* F
				mkdir G
				mv G\ -* G
				mkdir Gb
				mv Gb\ -* Gb
			fi
			cd ..
		fi
	done
	cd ..
  fi
done


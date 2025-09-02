############################################################
# Alexander Turinske's Profile
############################################################

############################################################
# Navigation
############################################################
alias updatebrew='echo "brew update && brew upgrade" && brew update && brew upgrade'
alias caliases='echo "cat ~/.oh-my-zsh/custom/*'
alias aliases='vim ~/.oh-my-zsh/custom/personal_aliases.zsh'
alias cdaliases='cd ~/.oh-my-zsh/custom/'
alias home='cd ~'
alias other='cd ~/other'
alias cloud='echo "cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/" && cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/'

# Make images smaller in size
alias pngquant='~/other/pngquant/pngquant'
# To make videos smaller in size, open the video with Quicktime and export the file to a lower resolution

###################################
# Python
###################################
#===   FUNCTION   ===============================
#          NAME: py_virtual_env
#   DESCRIPTION: Signs into a virtual environment (https://docs.python.org/3/tutorial/venv.html)
#   PARAMETER 1: the virtual env to sign into
#==================================
py_virtual_env () {
    local __envName=$1
    echo $__envName

    echo "source ~/venv/$__envName/bin/activate"
    source ~/venv/$__envName/bin/activate
}

#===   FUNCTION   ===============================
#          NAME: makegif
#   DESCRIPTION: Creates a gif from a mov
#   PARAMETER 1: path/to/input.mov
#   PARAMETER 2: speed of gif (default is slow, 20fps)
#   PARAMETER 3: path/to/output.gif (only required if you want to change the name of the file)
#==================================
function makegif {
  # inputPath=$1

  #[ $1 ] && speedArg=$2 || speedArg="s"
  #[[ $speedArg=="s" ]] && speed=20 || speed=10

  # outputPath=$3
  # [[ -z $outputPath ]] && { outputPath="${inputPath:0:-4}.gif" }

  # ffmpeg -i $inputPath -s 900x600 -pix_fmt rgb24 -r 20 -f gif - | gifsicle --optimize=3 --delay=3 > $outputPath
  echo "This method is deprecated because gifs are inefficient. Now uses makevideoperformant"
}

#===   FUNCTION   ===============================
#          NAME: makevideoperformant
#   DESCRIPTION: Creates a smaller .mov w/o audio from a .mov 
#   PARAMETER 1: path/to/input.mov
#   PARAMETER 2: path/to/output.mov (only required if you want to change the name of the file)
#==================================
function makevideoperformant {
  inputPath=$1

  outputPath=$2
  [[ -z $outputPath ]] && { outputPath="${inputPath:0:-4}_small.mov" }

  # This stopped working randomly. :shrug: Found different one online
  #ffmpeg -i $inputPath -c vp9 -b:v 0 -crf 41 $outputPath
  # -an removes audio
  ffmpeg -i $inputPath -s 1024x576 -c:a copy -an $outputPath
}

#===   FUNCTION   ===============================
#          NAME: makevideoperformantWithAudio
#   DESCRIPTION: Creates a smaller .mov w/ audio from a .mov 
#   PARAMETER 1: path/to/input.mov
#   PARAMETER 2: path/to/output.webm (only required if you want to change the name of the file)
#==================================
function makevideoperformantWithAudio {
  inputPath=$1

  outputPath=$2
  [[ -z $outputPath ]] && { outputPath="${inputPath:0:-4}_small.mov" }

  # This stopped working randomly. :shrug: Found different one online
  #ffmpeg -i $inputPath -c vp9 -b:v 0 -crf 41 $outputPath
  ffmpeg -i $inputPath -s 1024x576 -c:a copy $outputPath
}

###################################
# GPG
###################################
export GPG_TTY=$(tty)

###################################
# Ascii Art
###################################
alias dinoArt=~/other/ascii-art-gallery/itsasciitime.sh "$@"

<#
Title: Whack-a-duck
Date: 08/02/2022
Team: Capt Dorrough, Lt Monteith, Lt Voyer, Lt Walters
#>

#Global Variables
$guesserCounter = 0
$duckLocation = -1
$counter = 0
$counterEX = 0
[boolean]$stopPlay = $false
$placesDuckBeen = @()

#Screen Color -Goose 
$Host.UI.RawUI.BackgroundColor = 'Green'
$Host.UI.RawUI.ForegroundColor = 'Black'

#Function to start game with options to read rules, start game, or exit game
function WhackADuck {
   cls
   write "Welcome to Whack-a-Duck!`nWhat would you like to do?"
   write "1. Play Whack-a-Duck`n2. Go to Rules`n3. Exit game"
   [int]$decision = Read-Host "Please enter your selection"
   if ($decision -eq 1) {
    while ($Global:counter -lt 3 -and $stopPlay -eq $false) {
        if ($Global:counterEX % 8 -eq 0){
            $Global:counterEX = 0
            $Global:placesDuckBeen = @()
        }
        rngarray
        User
    }
    write "Congratulations! Dicky the Duck is now stuck in the muck, you win!"
    sleep 3
    [int]$successRate = 3/$Global:guesserCounter * 100
    Write-Output "You've made $Global:guesserCounter total guesses. You had a success rate of $successRate %"
   }
   elseif ($decision -eq 2) {
    [int]$rulesRead = 0
    while ($rulesRead -eq 0) {
    write "`nRules of Whack-a-Duck`n"
    write "Dicky the Duck is running amuck!`n1. Dicky the Duck is hiding in one of the nine boxes presented to the user.`n2. The user must correctly guess Dicky the Duck's location 3 times to win the game.`n3. The user will be prompted to enter a guess as to which numbered box Dicky is hiding in."
    write "4. After every guess the user will be told whether their guess is correct or not.`n5. After every guess Dicky the Duck will randomly hide in another box.`n`nBest of Luck!`n"
    $rulesRead = Read-Host "Please enter `"1`" to return to the Main Menu"
    }
    WhackADuck
   }
   elseif ($decision -eq 3) {
    Write "Thanks for playing Whack-a-Duck!"
    sleep 3
   }
   else {
    WhackADuck
   }
}
 
function rngarray {
    do{
    [int]$Global:duckLocation = 1..9 | Get-Random
    foreach ($num in $Global:placesDuckBeen){
        if ($num -eq $duckLocation){
            continue
        }
        else{
            break
        }
    }
    break
    }while(1 -eq 1)

}

#Function to check user input with where duck is in array and return answer
function decision($UserInput, $duckLocation) {
    return ($UserInput -eq $duckLocation) 
}


function User {
    displaybox
    [int]$numInput = read-host "`nGuess a number between 1 and 9 or enter 0 to Exit"
    if ($numInput -ge 1 -and $numInput -le 9) {
        $Global:guesserCounter++
        $Global:counterEX++
        if (decision $numInput $duckLocation) {
            displayDuckBox $numInput
            #place bong sound here
            Add-Type -AssemblyName presentationCore
            $bong = New-Object System.Windows.Media.MediaPlayer
            $bong.Open('C:\Users\carso\Documents\Powershell Proj\Duck Wack\taco_bell.mp3')
            $bong.Play()
            write "`nYou got Dicky the Duck!"
            $Global:counter++
            write "You've hit Dicky the Duck $Global:counter times"
            $Global:placesDuckBeen = @()
        }
        else {
            write "`nGet Ducked!"
            $Global:placesDuckBeen += $duckLocation
            #place nope sound here
            Add-Type -AssemblyName presentationCore
            $nope = New-Object System.Windows.Media.MediaPlayer
            $nope.Open('C:\Users\carso\Documents\Powershell Proj\Duck Wack\nope.mp3')
            $nope.Play()
            Write-Output "LOL YOU WERE WRONG DUCKY WAS ACTUALLY HERE"
            displayDuckBox ($duckLocation)
        }
    }
    elseif ($numInput -eq 0) {
         WhackADuck 
    }
    else {
         write-host  "You're Ducked! Try Again!"
    } 
}  

function displayDuckBox ($numInput) {
    if ($numInput -eq 1) {
        display1
    }
    elseif ($numInput -eq 2) {
        display2
    }
    elseif ($numInput -eq 3) {
        display3
    }
    elseif ($numInput -eq 4) {
        display4
    }
    elseif ($numInput -eq 5) {
        display5
    }
    elseif ($numInput -eq 6) {
        display6
    }
    elseif ($numInput -eq 7) {
        display7
    }
    elseif ($numInput -eq 8) {
        display8
    }
    elseif ($numInput -eq 9) {
        display9
    }
}

function displaybox {
    write "_________________________"
    write "|       |   	|	    |"
    write "|   1   |   2   |   3   |"
    write "|_______|_______|_______|"
    write "|       |       |       |"
    write "|   4   |   5   |   6   |"
    write "|_______|_______|_______|"
    write "|       |       |       |"
    write "|   7   |   8   |   9   |"
    write "|_______|_______|_______|"
}

function displayduck {
    write "    _  "
    write " __(.)< "
    write " \___)  "

}

function display1 {
    write "_________________________"
    write "|       |   	|	    |"
    write "| __(.)<|   2   |   3   |"
    write "|_\___)_|_______|_______|"
    write "|       |       |       |"
    write "|   4   |   5   |   6   |"
    write "|_______|_______|_______|"
    write "|       |       |       |"
    write "|   7   |   8   |   9   |"
    write "|_______|_______|_______|"
}

function display2 {
    write "_________________________"
    write "|       |   	|	    |"
    write "|   1   | __(.)<|   3   |"
    write "|_______|_\___)_|_______|"
    write "|       |       |       |"
    write "|   4   |   5   |   6   |"
    write "|_______|_______|_______|"
    write "|       |       |       |"
    write "|   7   |   8   |   9   |"
    write "|_______|_______|_______|"
}

function display3 {
    write "_________________________"
    write "|       |   	|	    |"
    write "|   1   |   2   | __(.)<|"
    write "|_______|_______|_\___)_|"
    write "|       |       |       |"
    write "|   4   |   5   |   6   |"
    write "|_______|_______|_______|"
    write "|       |       |       |"
    write "|   7   |   8   |   9   |"
    write "|_______|_______|_______|"
}

function display4 {
    write "_________________________"
    write "|       |   	|	    |"
    write "|   1   |   2   |   3   |"
    write "|_______|_______|_______|"
    write "|    _  |       |       |"
    write "| __(.)<|   5   |   6   |"
    write "|_\___)_|_______|_______|"
    write "|       |       |       |"
    write "|   7   |   8   |   9   |"
    write "|_______|_______|_______|"
}

function display5 {
    write "_________________________"
    write "|       |   	|	    |"
    write "|   1   |   2   |   3   |"
    write "|_______|_______|_______|"
    write "|       |    _  |       |"
    write "|   4   | __(.)<|   6   |"
    write "|_______|_\___)_|_______|"
    write "|       |       |       |"
    write "|   7   |   8   |   9   |"
    write "|_______|_______|_______|"
}

function display6 {
    write "_________________________"
    write "|       |   	|	    |"
    write "|   1   |   2   |   3   |"
    write "|_______|_______|_______|"
    write "|       |       |    _  |"
    write "|   4   |   5   | __(.)<|"
    write "|_______|_______|_\___)_|"
    write "|       |       |       |"
    write "|   7   |   8   |   9   |"
    write "|_______|_______|_______|"
}

function display7 {
    write "_________________________"
    write "|       |   	|	    |"
    write "|   1   |   2   |   3   |"
    write "|_______|_______|_______|"
    write "|       |       |       |"
    write "|   4   |   5   |   6   |"
    write "|_______|_______|_______|"
    write "|    _  |       |       |"
    write "| __(.)<|   8   |   9   |"
    write "|_\___)_|_______|_______|"
}

function display8 {
    write "_________________________"
    write "|       |   	|	    |"
    write "|   1   |   2   |   3   |"
    write "|_______|_______|_______|"
    write "|       |       |       |"
    write "|   4   |   5   |   6   |"
    write "|_______|_______|_______|"
    write "|       |    _  |       |"
    write "|   7   | __(.)<|   9   |"
    write "|_______|_\___)_|_______|"
}

function display9 {
    write "_________________________"
    write "|       |   	|	    |"
    write "|   1   |   2   |   3   |"
    write "|_______|_______|_______|"
    write "|       |       |       |"
    write "|   4   |   5   |   6   |"
    write "|_______|_______|_______|"
    write "|       |       |    _  |"
    write "|   7   |   8   | __(.)<|"
    write "|_______|_______|_\___)_|"
}

WhackADuck
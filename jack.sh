#!/usr/bin/env bash
##22/11/2026 100% handwritten !!! :)

##learning exercise !
##please don't gamble real money !!!

##let's set up an array of cards.

deckofcards=(A 2 3 4 5 6 7 8 9 10 J Q K)
numcards=${#deckofcards[*]}

A=11
J=10
Q=10
K=10

##debug
##echo "These are my cards ${deckofcards[*]}"
##card=${deckofcards[$((RANDOM%numcards))]}
##echo "You draw a $card"
##card=${deckofcards[$((RANDOM%numcards))]}
##echo "Dealer draws a $card"
##/debug

##let's go gamble!
cash=2000

while [[ "$choice" != "q" && "$ans" != "n" ]]; do

soft_aces=0
deal_aces=0

clear

splashfr=20
while (( splashfr > 0 )); do
        for frame in  '\\\\\\\\\*MINIJACK*/////////' '|||||||||*MINIJACK*|||||||||' '/////////*MINIJACK*\\\\\\\\\' '---------*MINIJACK*---------'; do
                printf "\r%s" "$frame"
                sleep 0.1
        splashfr=$(( splashfr-1 ))
        done
done

echo -e "\nYou have \$$cash."

while true; do
    read -rp "Place your bet: " bet || break 2

##strip the zeroes because octal
 bet=$(echo "$bet" | sed 's/^0*//')

##confirm # input, if afford, if < 64bit
    if [[ "$bet" =~ ^[0-9]+$ ]] && (( $bet <= $cash && ${#bet} <= 18 )) ; then
        break
    fi
    echo "Try again."
done


## Deal cards

for player in dealer you ; do

        card=${deckofcards[$((RANDOM%numcards))]}
        declare "$player=$card"

done

##Give player($you) 2 cards on first turn

firstdraw=true

while [[ "$firstdraw" == true ]]; do
        dcard=${deckofcards[$((RANDOM%numcards))]}
        echo "Dealers first card is $dealer"
sleep 0.5
        echo "Your starting hand is $you and $dcard"

if [[ $dealer == A ]]; then
   deal_aces=$((deal_aces + 1))
fi
if [[ $you == A || $dcard == A ]]; then
   soft_aces=$((soft_aces + 1))
fi
        you=$((dcard+you))

if (( you == 22)); then
	you=12
fi

if (( you == 21)); then
	natjack=1
fi
        firstdraw=false
done

##Main game loop


while (( you < 21 )); do
        sleep 0.5
        read -rp "Hit or Stay? q to quit game[h/s/q] " choice || break 2

        if [[ "$choice" == "q" ]]; then
        clear
         break

        elif [[ "$choice" == "h" ]]; then
        card=${deckofcards[$((RANDOM%numcards))]}
         echo "You draw $card"
sleep 0.5


if [[ $card == A ]]; then
    soft_aces=$((soft_aces + 1))
fi

	you=$((you+card))

while (( you > 21 && soft_aces > 0 )); do
    you=$((you - 10))
    soft_aces=$((soft_aces - 1))
done

         echo "Your total is $you"

        elif [[ "$choice" == "s" ]]; then
                break
        fi
done

[[ "$choice" == "q" ]] && break

##if $you blackjack

if (( you <= 21 )); then
        if (( you == 21)); then
blackjack=1
blackjackfr=30
sleep 1
        while (( blackjackfr > 0 )); do
        for frame in '\\\\\\\\\*BLACKJACK*/////////' '|||||||||*BLACKJACK*|||||||||' '/////////!BLACKJACK!\\\\\\\\\' '---------!BLACKJACK!---------' ; do
                printf "\r%s" "$frame"
                sleep 0.1
        blackjackfr=$(( blackjackfr - 1 ))
        done
        done
printf "\n"
fi

##dealer dealing

while (( dealer < 17 )); do
        card=${deckofcards[$((RANDOM%numcards))]}
        sleep 0.5
         echo "Dealer draws $card"
if [[ $card == A ]]; then
    deal_aces=$((deal_aces + 1))
fi


sleep 0.8
         dealer=$((dealer+card))

while (( dealer > 21 && deal_aces > 0 )); do
    dealer=$((dealer - 10))
    deal_aces=$((deal_aces - 1))
done

         echo "Dealer's total is $dealer"
sleep 0.5
        done
fi
sleep 0.5

##big bux
if (( natjack == 1 )); then
	natjack=0
        blackjack=0
	bet=$((bet*2))

elif (( blackjack == 1 )); then
	blackjack=0
	bet=$((bet*3/2))
fi

##game end

if (( you > 21 )); then
        cash=$((cash-bet))
        echo "You got $you! You're bust! -\$$bet"

elif (( dealer > 21)); then
        cash=$((cash+bet))
        echo -e "Dealer got $dealer, they're bust!\nYou win! +\$$bet"

elif (( you > dealer )); then
        cash=$((cash+bet))
        echo -e "You $you vs. $dealer Dealer\nYou Win! +\$$bet"

elif (( you < dealer )); then
        cash=$((cash-bet))
        echo -e "You $you vs. $dealer Dealer\nYou lose! -\$$bet"

else
        echo "It's a draw!"
fi

sleep 1

if (( ${#cash} >= 17 )) && (( $cash > 0 )); then
	echo "!!! YOU BROKE THE BANK !!! YOU WIN !!!"
##really pretty animation goes here.
	sleep 1
	read -rp "Press any button to retire." choice
	choice=q

elif (( cash > 0 )); then
        read -rp "Next round? [Enter/y/n] " ans || break

elif ((cash <= 0 )); then
	echo "You're bankrupt! No money left!"
	sleep 1
	read -rp "Hit [Enter] to restart or [q] to quit " choice || break
	cash=2000
fi

clear
done
clear

#! /usr/bin/bash
##22/11/2026 100% handwritten !!! :)

##let's set up an array of cards.

deckofcards=(A 2 3 4 5 6 7 8 9 10 J Q K)
numcards=${#deckofcards[*]}

A=11
J=10
Q=10
K=10

##echo "These are my cards ${deckofcards[*]}"

##card=${deckofcards[$((RANDOM%numcards))]}
##echo "You draw a $card"

##card=${deckofcards[$((RANDOM%numcards))]}
##echo "Dealer draws a $card"


##let's go gamble!
cash=1000

while [[ "$choice" != "q" && "$ans" != "n" ]]; do

soft_aces=0
deal_aces=0

splashfr=20
while (( splashfr > 0 )); do
clear
        for frame in '|||||||||*MINIJACK*|||||||||' '/////////*MINIJACK*\\\\\\\\\' '---------*MINIJACK*---------' '\\\\\\\\\*MINIJACK*/////////'; do
                printf "\r%s" "$frame"
                sleep 0.08
        splashfr=$(( splashfr-1 ))
        done
done
##echo "---------MINI JACK---------"
        echo -e "\nYou have \$$cash."

while true; do
    read -r -p "Place your bet: " bet

    if [[ "$bet" =~ ^[0-9]+$ ]] && (( "$bet" <= "$cash" )); then
        break
    fi
    echo "Try again."
done

## Deal cards

for player in dealer you ; do

        card=${deckofcards[$((RANDOM%numcards))]}
        declare "$player=$card"

done

##Give player 2 cards on first turn

firstdraw=true

while [[ "$firstdraw" == true ]]; do
        dcard=${deckofcards[$((RANDOM%numcards))]}
        echo "Dealers first card is $dealer"

sleep 0.5
        echo "Your starting hand is $you and $dcard"

if [[ $dealer == A ]]; then
   deal_aces=$((deal_aces + 1))
fi
if [[ $you == A ]]; then
    soft_aces=$((soft_aces + 1))
fi
if [[ $dcard == A ]]; then
   soft_aces=$((soft_aces + 1))
fi

        you=$((dcard+you))

if (( you==22 )); then
        you=12
fi
        firstdraw=false
done

##Main game loop

while (( you < 21 )); do
        sleep 0.5
        read -r -p "Hit or Stay? q to quit game[h/s/q] " choice || break

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

##game end conditions

if (( you <= 21 )); then
        if (( you == 21)); then
blackjackfr=30
sleep 1
        while ((you == 21 && blackjackfr > 0 )); do
        for frame in '|||||||||!BLACKJACK!|||||||||' '/////////*BLACKJACK*\\\\\\\\\' '---------!BLACKJACK!---------' '\\\\\\\\\*BLACKJACK*/////////'; do
                printf "\r%s" "$frame"
                sleep 0.1
        blackjackfr=$(( blackjackfr - 1 ))
        done
        done
printf "\n"

##      echo "***BLACKJACK***"
        fi

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
        read -r -p "Play again?[y/n] " ans


if ((cash <= 0 )); then
        echo "You're bankrupt! No money left!"
        break
fi

clear
done

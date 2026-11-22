#! /usr/bin/bash


cash=1000

while [[ "$choice" != "q" && "$ans" != "n" ]]; do

clear
echo "---------MINI JACK---------"
sleep 0.5
for player in dealer you ; do

        card=$((RANDOM%11+1))
        declare "$player=$card"
done

        echo "You have \$$cash."

while true; do
    read -r -p "Place your bet: " bet

    if [[ "$bet" =~ ^[0-9]+$ ]] && (( "$bet" <= "$cash" )); then
        break
    fi
    echo "Try again."
done


        echo "Dealers first card is $dealer"
sleep 0.5
        echo "Your first card is $you"

while (( you < 21 )); do
        sleep 0.5
        read -r -p "Hit or Stay? q to quit game[h/s/q] " choice || break

        if [[ "$choice" == "q" ]]; then
        clear
         break

        elif [[ "$choice" == "h" ]]; then
        card=$((RANDOM%11+1))
         echo "You draw $card"
sleep 0.5
        you=$((you+card))
         echo "Your total is $you"

        elif [[ "$choice" == "s" ]]; then
                break
        fi
done

[[ "$choice" == "q" ]] && break

if (( you <= 21 )); then

while (( dealer < 17 )); do
        card=$((RANDOM%11+1))
         echo "Dealer draws $card"
sleep 0.8
         dealer=$((dealer+card))
         echo "Dealer's total is $dealer"
sleep 1
        done
fi
sleep 1

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

        read -r -p "Play again?[y/n] " ans


if ((cash <= 0 )); then
        echo "You're bankrupt! No money left!"
        break
fi

clear
done

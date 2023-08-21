import random
from replit import clear

cards = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]


def deal_card():
    first_card = random.choice(cards)
    return first_card

def calculate_score(cards):
    if sum(cards) == 21 and len(cards) == 2:
        return 0
    if 11 in cards and sum(cards) > 21:
        cards.remove(11)
        cards.append(1)
    return sum(cards)

def compare(user_score, computer_score):
    if user_score == computer_score:
        return "Draw."
    elif computer_score == 0:
        return "You lose. The computer wins."
    elif user_score == 0:
        return "You win. The computer loses."
    elif user_score > 21:
        return "You went over. You lose."
    elif computer_score > 21:
        return "The computer went over. You win."
    elif user_score > computer_score:
        return "You win."
    else:
        return "You lose."


def play_game():
    user_cards = []
    computer_cards = []
    is_game_over = False

    for _ in range(2):
        user_cards.append(deal_card())
        computer_cards.append(deal_card())


    while not is_game_over:
        user_score = calculate_score(user_cards)
        computer_score = calculate_score(computer_cards)

        print(f"Your cards: {user_cards}. Your current score {user_score}")
        print(f"Computer cards: {computer_cards[0]}.")

        if user_score == 0 or computer_score == 0 or user_score > 21:
            is_game_over = True
        else:
            user_continue = input(
                "Type 'yes' to get another card. Type 'no' to pass. ")
            if user_continue == "yes":
                user_cards.append(deal_card())
            else:
                is_game_over = True


    while computer_score != 0 and computer_score == 17:
        computer_cards.append(deal_card())
        computer_score = calculate_score(computer_cards)

    print(
        f"      Your final cards: {user_cards}. Your final score: {user_score}"
    )
    print(
        f"      Computer final cards: {computer_cards}. Your final score: {computer_score}"
    )
    print(compare(user_score, computer_score))


while input("Type 'yes' if you want to restart the game. Type 'no' if you want to exit. ") == "yes":
    clear()
    play_game()

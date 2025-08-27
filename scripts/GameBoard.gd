extends Node3D

@onready var player1_hand = $Player1Hand
@onready var player2_hand = $Player2Hand
@onready var battlefield = $Battlefield
@onready var player1_deck = []
@onready var player2_deck = []
@onready var current_player = 1
@onready var player1_life = 40
@onready var player2_life = 40

func _ready():
    load_decks()
    start_game()

func load_decks():
    var card_data = load("res://data/sample_cards.json")
    player1_deck = card_data["player1_deck"].duplicate()
    player2_deck = card_data["player2_deck"].duplicate()

func start_game():
    # Shuffle decks
    player1_deck.shuffle()
    player2_deck.shuffle()
    # Draw starting hands
    for i in range(7):
        draw_card(1)
        draw_card(2)

func draw_card(player):
    var deck = player1_deck if player == 1 else player2_deck
    var hand = player1_hand if player == 1 else player2_hand
    if deck.size() > 0:
        var card = deck.pop_front()
        var card_instance = preload("res://scenes/Card.tscn").instantiate()
        card_instance.set_card(card)
        hand.add_child(card_instance)

func end_turn():
    current_player = 2 if current_player == 1 else 1
    draw_card(current_player)
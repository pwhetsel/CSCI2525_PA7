;TITLE: PA7				(pa7functions.inc)
;
; Author: Patrick Whetsel
; Creation Date: 4/21/13
;
; Program Description: This program prompts the user for the number of human players in a game in tic-tac-toe and proceeds to play the game,
;					   adding computer players as neccesary.

INCLUDE Irvine32.inc

;prototype procedure to prompt user for and store number of human players in game
player_prompt PROTO, player_prompt_ptr:PTR byte, human_players_ptr:PTR byte

;prototype for procedure to write current board to screen along with key for input
print_board PROTO

;prototype for procedure for computer to take turn for player X, tries to win,block,play randomly
comp_turn_x PROTO

;prototype for procedure to prompt human to take turn for player X
hum_turn_x PROTO

;prototype for procedure for computer to take turn for player O, tries to win,block,play randomly
comp_turn_o PROTO

;prototype for procedure to prompt human to take turn for player O
hum_turn_o PROTO

;prototype for procedue to check if player x has 3 in a row anywhere on the board, if true returns 'y' in eax
check_win_x PROTO

;prototype for procedue to check if player o has 3 in a row anywhere on the board, if true returns 'y' in eax
check_win_o PROTO
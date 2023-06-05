# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: wkonings <wkonings@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2023/01/16 15:30:52 by wkonings      #+#    #+#                  #
#    Updated: 2023/06/05 14:10:01 by wkonings      ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

# ----------------------------------------- #
# --------------- VARIABLES --------------- #
# ----------------------------------------- #

NAME 	:= webserv
FLAGS 	:= -std=c++98 #-Wall -Wextra -Werror -std=c++98
DEBUG 	:= -g -fsanitize=address
MAKEFILE:= makefile
CC		:= c++

# ---------------------------------------- #
# --------------- DIRECTORIES ------------ #
# ---------------------------------------- #

SRC_DIR		:= .
OBJ_DIR		:= obj

# ----------------------------------------- #
# --------------- FILES ------------------- #
# ----------------------------------------- #

HEADER_FILES := 

MAIN_FILES	:= main

FILES	:=	$(MAIN_FILES:%=%.cpp)

# SRCS	:=	$(addprefix $(SRC_DIR)/, $(FILES))
SRCS	:=	$(FILES)
OBJS	:=	$(addprefix $(OBJ_DIR)/, $(FILES:%.cpp=%.o))
HEADERS	:=	$(HEADER_FILES:%=%.hpp)

# ----------------------------------------- #
# --------- COLOURS / FORMATTING ---------- #
# ----------------------------------------- #

#Formatting
RESET	:= \1\33[0m\2
END		:= \1\33[0m\2\3

#Colours
YELLOW	:= \1\33[38;5;220m\2
BLACK	:= \1\33[38;5;232m\2
ORANGE	:= \1\33[38;5;202m\2
RED		:= \1\33[38;5;196m\2
PINK	:= \1\33[38;5;198m\2
GREEN	:= \1\33[38;5;28m\2
BLUE	:= \1\33[38;5;33m\2
L_BLUE	:= \1\33[38;5;69m\2
D_BLUE	:= \1\33[38;5;21m\2
GREY	:= \1\33[38;5;242m\2
PURPLE	:= \1\33[38;5;92m\2
VIOLET	:= \1\33[38;5;183m\2

# ----------------------------------------- #
# --------------- RECIPES ----------------- #
# ----------------------------------------- #

$(NAME): $(HEADERS) $(OBJS) $(MAKEFILE)
	@printf "$(BLUE)Compiling $(YELLOW)$(NAME)\n$(END)"
	@$(CC) $(FLAGS) $(OBJS) -o $(NAME) 
	@printf "$(YELLOW)$(NAME) compiled!\n$(END)"

all: $(NAME)

$(OBJ_DIR)/%.o:$(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	@printf "$(BLUE)Compiling $(D_BLUE)$(notdir $@) $(RESET)from $(L_BLUE)$(notdir $<)$(END)\n"
	@$(CC) $(FLAGS) -c $< -o $@

clean:
	@printf "$(BLUE)Cleaning up $(YELLOW)$(NAME)!\n$(END)"
	/bin/rm -rf $(OBJ_DIR)

fclean:	clean
	/bin/rm -f $(NAME)
	@printf "$(BLUE)Fully cleaned $(YELLOW)$(NAME)\n$(END)"

debug: $(HEADERS) $(OBJS) $(MAKEFILE)
	@printf "$(BLUE)Compiling $(YELLOW)$(NAME)\n$(END)"
	@$(CC) $(DEBUG) $(OBJS) -o $(NAME) 
	@printf "$(YELLOW)$(NAME) compiled!\n$(END)"

re: fclean all

pog:
	@printf "\n$(RED)"
	@printf "⣿⣿⣿⣿⡿⠟⠛⠛⠛⠛⠉⠉⠙⠛⠛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠟   \n"
	@printf "⣿⣿⣯⣥⣤⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣏⣀⣀⣀⡀  \n"
	@printf "⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⠻⠿⠟⠉⠉⠉⢻⣿⣿⣿⡿⠟⠋⣡⣼⣿⣿⣿⡄ \n"
	@printf "⣿⣿⣿⣟⣭⣤⣶⣶⣿⣿⠃⠀⠀⢀⣀⣤⣶⣿⣿⣿⣿⡅⡀⢀⣩⣤⣤    \n"
	@printf "⣿⣿⣿⣿⣿⣿⣛⡛⠛⠛⠛⢋⣩⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⠛⠛⠓⠠   \n"
	@printf "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⣤⣤⣦  \n"
	@printf "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇ \n"
	@printf "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⠿⢿⡿⢿⣿⣿⣿⠃ \n"
	@printf "⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣥⣄⣀⣀⠀⠀⠀⠀⠀⢰⣾⣿⣿⠏  \n"
	@printf "⠀⠀⠀⠀⠀⠀⠉⣩⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣜⡻⠋    \n"
	@printf "⣰⣾⣷⣶⣿⣾⣖⣻⣿⣿⡿⣿⣿⣿⣿⠿⠿⠟⠛⠛⠛⠋⠉⠉⢉⡽⠃    \n"
	@printf "⣿⣿⣿⣿⣿⣿⡉⠉⠉⠛⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⡤⠚⠉      \n"
	@printf "⠛⠛⣿⣿⣿⣿⣿⣿⣿⠉⠛⢶⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⡇        \n"
	@printf "⠠⣾⣿⣿⣿⣿⣿⠿⠟⠃⠀⠀⠀⠈⠲⣴⣦⣤⣤⣤⣶⡾⠁        \n"
	@printf "⠄⠈⠉⠻⢿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠛⠛⠉          \n"
	@printf "$(END)"

.PHONY: all clean fclean re pog

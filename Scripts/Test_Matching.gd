extends Node

var consumable_items :=[
	{"type": "Consumable","name": "Peach","effect": "Health","texture": preload("res://assets/Icons/icon31.png")},
	{"type": "Gift","name": "Gemstone","effect": "","texture": preload("res://assets/Icons/icon21.png")},
]

var spawnable_items := [
	{"type": "Mineral","name": "Ruby","effect": "Red as blood","texture": preload("res://assets/Icons/icon26.png")},
	{"type": "Mineral","name": "Diamond","effect": "Sparks and flases","texture": preload("res://assets/Icons/icon31.png")},
	{"type": "Mineral","name": "Emerald","effect": "Appreciated by villagers","texture": preload("res://assets/Icons/icon25.png")},
	{"type": "Mineral","name": "Amethyst","effect": "Smells like grapes","texture": preload("res://assets/Icons/icon3.png")},
	{"type": "Organic","name": "Rose","effect": "Comes with spines","texture": preload("res://assets/Icons/icon31.png")},
	{"type": "Organic","name": "Mushroom","effect": "Can f+ck some1up","texture": preload("res://assets/Icons/icon32.png")},
	{"type": "Organic","name": "Wild Grapes","effect": "Not that sweet","texture": preload("res://assets/Sprites/grapes.png")},
	{"type": "Organic","name": "Mint Leaf","effect": "Refreshing taste","texture": preload("res://assets/Sprites/mint.png")},
	{"type": "Memento","name": "Leather Boots","effect": "Smells really bad","texture": preload("res://assets/Sprites/boot.png")},
	{"type": "Memento","name": "Rusty Rod","effect": "Ancient lost tool","texture": preload("res://assets/Sprites/coal.png")},
	{"type": "Memento","name": "Rags Shirt","effect": "Regular peasants clothing","texture": preload("res://assets/Sprites/shirt.png")},
	{"type": "Memento","name": "Gold Crown","effect": "Can't be sold","texture": preload("res://assets/Sprites/crown.png")},
]

var craftable_items := [
	{"type": "Potion","name": "Crimson Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon15.png")},
	{"type": "Potion","name": "Crimson Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon15.png")},
	{"type": "Potion","name": "Crimson Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon15.png")},
	{"type": "Potion","name": "Crimson Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon15.png")},
	{"type": "Potion","name": "Sparkling Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon12.png")},
	{"type": "Potion","name": "Sparkling Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon12.png")},
	{"type": "Potion","name": "Sparkling Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon12.png")},
	{"type": "Potion","name": "Sparkling Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon12.png")},
	{"type": "Potion","name": "Verdant Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon10.png")},
	{"type": "Potion","name": "Verdant Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon10.png")},
	{"type": "Potion","name": "Verdant Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon10.png")},
	{"type": "Potion","name": "Verdant Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon10.png")},
	{"type": "Potion","name": "Violet Joy Potion","effect": "Be happy!","texture": preload("res://assets/Icons/icon6.png")},
	{"type": "Potion","name": "Violet Calm Potion","effect": "Calmness in a bottle","texture": preload("res://assets/Icons/icon6.png")},
	{"type": "Potion","name": "Violet Warming Potion","effect": "For the cold days","texture": preload("res://assets/Icons/icon6.png")},
	{"type": "Potion","name": "Violet Cooling Potion","effect": "Refreshing!","texture": preload("res://assets/Icons/icon6.png")},
]

var crafting_recipes := [
	# Crimson Joy Potion variations
	{"type": "Recipe","name": "Mundane Crimson Joy Potion","recipe": "Ruby,Rose,Rags Shirt"},
	{"type": "Recipe","name": "Royal Crimson Joy Potion","recipe": "Ruby,Rose,Gold Crown"},
	{"type": "Recipe","name": "Strong Crimson Joy Potion","recipe": "Ruby,Rose,Leather Boots"},
	{"type": "Recipe","name": "Ancient Crimson Joy Potion","recipe": "Ruby,Rose,Rusty Rod"},

	# Crimson Calm Potion variations
	{"type": "Recipe","name": "Mundane Crimson Calm Potion","recipe": "Ruby,Mushroom,Rags Shirt"},
	{"type": "Recipe","name": "Royal Crimson Calm Potion","recipe": "Ruby,Mushroom,Gold Crown"},
	{"type": "Recipe","name": "Strong Crimson Calm Potion","recipe": "Ruby,Mushroom,Leather Boots"},
	{"type": "Recipe","name": "Ancient Crimson Calm Potion","recipe": "Ruby,Mushroom,Rusty Rod"},

	# Crimson Warming Potion variations
	{"type": "Recipe","name": "Mundane Crimson Warming Potion","recipe": "Ruby,Wild Grapes,Rags Shirt"},
	{"type": "Recipe","name": "Royal Crimson Warming Potion","recipe": "Ruby,Wild Grapes,Gold Crown"},
	{"type": "Recipe","name": "Strong Crimson Warming Potion","recipe": "Ruby,Wild Grapes,Leather Boots"},
	{"type": "Recipe","name": "Ancient Crimson Warming Potion","recipe": "Ruby,Wild Grapes,Rusty Rod"},

	# Crimson Cooling Potion variations
	{"type": "Recipe","name": "Mundane Crimson Cooling Potion","recipe": "Ruby,Mint Leaf,Rags Shirt"},
	{"type": "Recipe","name": "Royal Crimson Cooling Potion","recipe": "Ruby,Mint Leaf,Gold Crown"},
	{"type": "Recipe","name": "Strong Crimson Cooling Potion","recipe": "Ruby,Mint Leaf,Leather Boots"},
	{"type": "Recipe","name": "Ancient Crimson Cooling Potion","recipe": "Ruby,Mint Leaf,Rusty Rod"},

	# Sparkling Joy Potion variations
	{"type": "Recipe","name": "Mundane Sparkling Joy Potion","recipe": "Diamond,Rose,Rags Shirt"},
	{"type": "Recipe","name": "Royal Sparkling Joy Potion","recipe": "Diamond,Rose,Gold Crown"},
	{"type": "Recipe","name": "Strong Sparkling Joy Potion","recipe": "Diamond,Rose,Leather Boots"},
	{"type": "Recipe","name": "Ancient Sparkling Joy Potion","recipe": "Diamond,Rose,Rusty Rod"},

	# Sparkling Calm Potion variations
	{"type": "Recipe","name": "Mundane Sparkling Calm Potion","recipe": "Diamond,Mushroom,Rags Shirt"},
	{"type": "Recipe","name": "Royal Sparkling Calm Potion","recipe": "Diamond,Mushroom,Gold Crown"},
	{"type": "Recipe","name": "Strong Sparkling Calm Potion","recipe": "Diamond,Mushroom,Leather Boots"},
	{"type": "Recipe","name": "Ancient Sparkling Calm Potion","recipe": "Diamond,Mushroom,Rusty Rod"},

	# Sparkling Warming Potion variations
	{"type": "Recipe","name": "Mundane Sparkling Warming Potion","recipe": "Diamond,Wild Grapes,Rags Shirt"},
	{"type": "Recipe","name": "Royal Sparkling Warming Potion","recipe": "Diamond,Wild Grapes,Gold Crown"},
	{"type": "Recipe","name": "Strong Sparkling Warming Potion","recipe": "Diamond,Wild Grapes,Leather Boots"},
	{"type": "Recipe","name": "Ancient Sparkling Warming Potion","recipe": "Diamond,Wild Grapes,Rusty Rod"},

	# Sparkling Cooling Potion variations
	{"type": "Recipe","name": "Mundane Sparkling Cooling Potion","recipe": "Diamond,Mint Leaf,Rags Shirt"},
	{"type": "Recipe","name": "Royal Sparkling Cooling Potion","recipe": "Diamond,Mint Leaf,Gold Crown"},
	{"type": "Recipe","name": "Strong Sparkling Cooling Potion","recipe": "Diamond,Mint Leaf,Leather Boots"},
	{"type": "Recipe","name": "Ancient Sparkling Cooling Potion","recipe": "Diamond,Mint Leaf,Rusty Rod"},

	# Verdant Joy Potion variations
	{"type": "Recipe","name": "Mundane Verdant Joy Potion","recipe": "Emerald,Rose,Rags Shirt"},
	{"type": "Recipe","name": "Royal Verdant Joy Potion","recipe": "Emerald,Rose,Gold Crown"},
	{"type": "Recipe","name": "Strong Verdant Joy Potion","recipe": "Emerald,Rose,Leather Boots"},
	{"type": "Recipe","name": "Ancient Verdant Joy Potion","recipe": "Emerald,Rose,Rusty Rod"},

	# Verdant Calm Potion variations
	{"type": "Recipe","name": "Mundane Verdant Calm Potion","recipe": "Emerald,Mushroom,Rags Shirt"},
	{"type": "Recipe","name": "Royal Verdant Calm Potion","recipe": "Emerald,Mushroom,Gold Crown"},
	{"type": "Recipe","name": "Strong Verdant Calm Potion","recipe": "Emerald,Mushroom,Leather Boots"},
	{"type": "Recipe","name": "Ancient Verdant Calm Potion","recipe": "Emerald,Mushroom,Rusty Rod"},

	# Verdant Warming Potion variations
	{"type": "Recipe","name": "Mundane Verdant Warming Potion","recipe": "Emerald,Wild Grapes,Rags Shirt"},
	{"type": "Recipe","name": "Royal Verdant Warming Potion","recipe": "Emerald,Wild Grapes,Gold Crown"},
	{"type": "Recipe","name": "Strong Verdant Warming Potion","recipe": "Emerald,Wild Grapes,Leather Boots"},
	{"type": "Recipe","name": "Ancient Verdant Warming Potion","recipe": "Emerald,Wild Grapes,Rusty Rod"},

	# Verdant Cooling Potion variations
	{"type": "Recipe","name": "Mundane Verdant Cooling Potion","recipe": "Emerald,Mint Leaf,Rags Shirt"},
	{"type": "Recipe","name": "Royal Verdant Cooling Potion","recipe": "Emerald,Mint Leaf,Gold Crown"},
	{"type": "Recipe","name": "Strong Verdant Cooling Potion","recipe": "Emerald,Mint Leaf,Leather Boots"},
	{"type": "Recipe","name": "Ancient Verdant Cooling Potion","recipe": "Emerald,Mint Leaf,Rusty Rod"},

	# Violet Joy Potion variations
	{"type": "Recipe","name": "Mundane Violet Joy Potion","recipe": "Amethyst,Rose,Rags Shirt"},
	{"type": "Recipe","name": "Royal Violet Joy Potion","recipe": "Amethyst,Rose,Gold Crown"},
	{"type": "Recipe","name": "Strong Violet Joy Potion","recipe": "Amethyst,Rose,Leather Boots"},
	{"type": "Recipe","name": "Ancient Violet Joy Potion","recipe": "Amethyst,Rose,Rusty Rod"},

	# Violet Calm Potion variations
	{"type": "Recipe","name": "Mundane Violet Calm Potion","recipe": "Amethyst,Mushroom,Rags Shirt"},
	{"type": "Recipe","name": "Royal Violet Calm Potion","recipe": "Amethyst,Mushroom,Gold Crown"},
	{"type": "Recipe","name": "Strong Violet Calm Potion","recipe": "Amethyst,Mushroom,Leather Boots"},
	{"type": "Recipe","name": "Ancient Violet Calm Potion","recipe": "Amethyst,Mushroom,Rusty Rod"},

	# Violet Warming Potion variations
	{"type": "Recipe","name": "Mundane Violet Warming Potion","recipe": "Amethyst,Wild Grapes,Rags Shirt"},
	{"type": "Recipe","name": "Royal Violet Warming Potion","recipe": "Amethyst,Wild Grapes,Gold Crown"},
	{"type": "Recipe","name": "Strong Violet Warming Potion","recipe": "Amethyst,Wild Grapes,Leather Boots"},
	{"type": "Recipe","name": "Ancient Violet Warming Potion","recipe": "Amethyst,Wild Grapes,Rusty Rod"},

	# Violet Cooling Potion variations
	{"type": "Recipe","name": "Mundane Violet Cooling Potion","recipe": "Amethyst,Mint Leaf,Rags Shirt"},
	{"type": "Recipe","name": "Royal Violet Cooling Potion","recipe": "Amethyst,Mint Leaf,Gold Crown"},
	{"type": "Recipe","name": "Strong Violet Cooling Potion","recipe": "Amethyst,Mint Leaf,Leather Boots"},
	{"type": "Recipe","name": "Ancient Violet Cooling Potion","recipe": "Amethyst,Mint Leaf,Rusty Rod"}
]


# Función para obtener la clave de la receta (ordenada)
func get_recipe_key(ingredients):
	var sorted_ingredients = ingredients.duplicate()

	print("sorted ingredientes",sorted_ingredients)
	return String(",".join(sorted_ingredients))

# Función para encontrar una receta válida y craftear la poción
func craft_potion(input_items):
	# Extraer nombres de los ingredientes de entrada
	var ingredient_names = []
	for item in input_items:
		if item != null:
			ingredient_names.append(item["name"])
			print(ingredient_names)
	
	# Asegurarse de que se tengan tres ingredientes
	if ingredient_names.size() != 3:
		print("Debe tener exactamente tres ingredientes en los espacios de entrada.")
		return
	
	# Crear la clave de la receta
	var recipe_key = get_recipe_key(ingredient_names)
	
	# Buscar en las recetas
	for recipe in crafting_recipes:
		if recipe.has("recipe") and recipe["recipe"] == recipe_key:
			print("Receta encontrada: ", recipe["name"])
			return
	print("Receta a buscar",str(recipe_key))
	print("No se encontró una receta con la combinación proporcionada.")

func get_input_items():
	pass

# Ejemplo de uso
func _ready():
	var input_items = [
		{"type": "Mineral", "name": "Ruby", "effect": "Red as blood"},
		{"type": "Organic", "name": "Rose", "effect": "Comes with spines"},
		{"type": "Memento", "name": "Rags Shirt", "effect": "Regular peasants clothing"}
	]
	
	craft_potion(input_items)  # Llama a la función para probar el crafteo

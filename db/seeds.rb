User.create!(
  email: "user1@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: "user"
)

User.create!(
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: "admin"
)


# Створення брендів
toyota = Brand.create!(name: 'Toyota')
ford = Brand.create!(name: 'Ford')
bmw = Brand.create!(name: 'BMW')

# Створення моделей
corolla = toyota.models.create!(name: 'Corolla')
camry = toyota.models.create!(name: 'Camry')
focus = ford.models.create!(name: 'Focus')
mustang = ford.models.create!(name: 'Mustang')
x5 = bmw.models.create!(name: 'X5')
_320i = bmw.models.create!(name: '320i')

# Створення двигунів
corolla_engine = Engine.create!(name: '1.8L I4')
camry_engine = Engine.create!(name: '2.5L I4')
focus_engine = Engine.create!(name: '3.0L V6')
mustang_engine = Engine.create!(name: '5.0L V8')
x5_engine = Engine.create!(name: '2.0L I4')
_320i_engine = Engine.create!(name: '3.0L I6')

# Створення років
year_2019 = Year.create!(year: 2019)
year_2020 = Year.create!(year: 2020)
year_2021 = Year.create!(year: 2021)
year_2022 = Year.create!(year: 2022)

# Створення записів ModelYear
corolla_2020 = ModelYear.create!(model: corolla, year: year_2020)
camry_2021 = ModelYear.create!(model: camry, year: year_2021)
focus_2019 = ModelYear.create!(model: focus, year: year_2019)
mustang_2022 = ModelYear.create!(model: mustang, year: year_2022)
x5_2020 = ModelYear.create!(model: x5, year: year_2020)
_320i_2021 = ModelYear.create!(model: _320i, year: year_2021)

# Зв'язування двигунів з ModelYear
ModelYearEngine.create!(model_year: corolla_2020, engine: corolla_engine)
ModelYearEngine.create!(model_year: camry_2021, engine: camry_engine)
ModelYearEngine.create!(model_year: focus_2019, engine: focus_engine)
ModelYearEngine.create!(model_year: mustang_2022, engine: mustang_engine)
ModelYearEngine.create!(model_year: x5_2020, engine: x5_engine)
ModelYearEngine.create!(model_year: _320i_2021, engine: _320i_engine)

# Створюємо частини
engine_oil = Part.create!(name: 'Engine Oil')
brake_pads = Part.create!(name: 'Brake Pads')
air_filter = Part.create!(name: 'Air Filter')

# Створюємо характеристики для Engine Oil
viscosity = Characteristic.create!(name: 'Viscosity')
volume = Characteristic.create!(name: 'Volume')

# Зв'язуємо характеристики з Engine Oil
engine_oil.characteristics << viscosity
engine_oil.characteristics << volume

# Створюємо характеристики для Brake Pads
material = Characteristic.create!(name: 'Material')
dimensions = Characteristic.create!(name: 'Dimensions')

# Зв'язуємо характеристики з Brake Pads
brake_pads.characteristics << material
brake_pads.characteristics << dimensions

# Створюємо характеристики для Air Filter
filter_type = Characteristic.create!(name: 'Filter Type')
air_filter.characteristics << filter_type

# Створення продуктів
toyota_engine_oil = Product.create!(name: 'Toyota Engine Oil 5L', description: 'Premium synthetic oil for Toyota engines', price: 35.99, stock: 100, part: engine_oil)
ford_brake_pads = Product.create!(name: 'Ford Brake Pads Set', description: 'Complete set of brake pads for Ford vehicles', price: 109.99, stock: 50, part: brake_pads)
bmw_air_filter = Product.create!(name: 'BMW Air Filter', description: 'Air filter for BMW vehicles', price: 19.99, stock: 200, part: air_filter)

# Прив'язування продуктів до марок
BrandProduct.create!(brand: toyota, product: toyota_engine_oil)
BrandProduct.create!(brand: ford, product: ford_brake_pads)
BrandProduct.create!(brand: bmw, product: bmw_air_filter)

# Створення продуктів для ModelYear
corolla_oil = Product.create!(name: 'Corolla Engine Oil 5L', description: 'Engine oil for Toyota Corolla', price: 30.99, stock: 150, part: engine_oil)
camry_oil = Product.create!(name: 'Camry Engine Oil 2L', description: 'Engine oil for Toyota Camry', price: 33.99, stock: 120, part: engine_oil)

# Прив'язування продуктів до ModelYear
ModelYearProduct.create!(model_year: corolla_2020, product: corolla_oil)
ModelYearProduct.create!(model_year: camry_2021, product: camry_oil)

# Створення продуктів для двигунів (ModelYearEngine)
corolla_engine_oil = Product.create!(name: 'Corolla 1.8L Engine Oil 3L', description: 'Engine oil for Corolla 1.8L engine', price: 32.99, stock: 110, part: engine_oil)
camry_engine_oil = Product.create!(name: 'Camry 2.5L Engine Oil 2L', description: 'Engine oil for Camry 2.5L engine', price: 34.99, stock: 100, part: engine_oil)

# Прив'язування продуктів до двигунів
EngineProduct.create!(engine: corolla_engine, product: corolla_engine_oil)
EngineProduct.create!(engine: camry_engine, product: camry_engine_oil)


# Додавання значень характеристик для Engine Oil
viscosity_1 = CharacteristicValue.create!(characteristic: viscosity, value: '5W-30')
viscosity_2 = CharacteristicValue.create!(characteristic: viscosity, value: '10W-40')

volume_1 = CharacteristicValue.create!(characteristic: volume, value: "5L")
volume_2 = CharacteristicValue.create!(characteristic: volume, value: "2L")
volume_3 = CharacteristicValue.create!(characteristic: volume, value: "3L")

# Додавання значень характеристик для Brake Pads
material_1 = CharacteristicValue.create!(characteristic: material, value: 'Ceramic')
material_2 = CharacteristicValue.create!(characteristic: material, value: 'Semi-Metallic')

# Створення значення характеристики для Brake Pads
dimensions_1 = CharacteristicValue.create!(characteristic: dimensions, value: '100x50x20mm')

# Додавання значень характеристик для Air Filter
filter_type_1 = CharacteristicValue.create!(characteristic: filter_type, value: 'HEPA')
filter_type_2 = CharacteristicValue.create!(characteristic: filter_type, value: 'Activated Carbon')

# Додавання значень характеристик для продуктів
ProductCharacteristicValue.create!(product: toyota_engine_oil, characteristic_value: viscosity_1)
ProductCharacteristicValue.create!(product: toyota_engine_oil, characteristic_value: volume_1)  # Volume for Engine Oil (5L)

ProductCharacteristicValue.create!(product: ford_brake_pads, characteristic_value: material_2)
ProductCharacteristicValue.create!(product: ford_brake_pads, characteristic_value: dimensions_1)  # Dimensions for Brake Pads

ProductCharacteristicValue.create!(product: bmw_air_filter, characteristic_value: filter_type_1)
ProductCharacteristicValue.create!(product: bmw_air_filter, characteristic_value: filter_type_2)

# Додавання значень характеристик для продуктів, пов'язаних з ModelYear
ProductCharacteristicValue.create!(product: corolla_oil, characteristic_value: viscosity_2)
ProductCharacteristicValue.create!(product: corolla_oil, characteristic_value: volume_1)  # Volume for Corolla Engine Oil (5L)

ProductCharacteristicValue.create!(product: camry_oil, characteristic_value: viscosity_1)
ProductCharacteristicValue.create!(product: camry_oil, characteristic_value: volume_2)  # Volume for Camry Engine Oil (2L)

# Додавання значень характеристик для продуктів, пов'язаних з двигунами
ProductCharacteristicValue.create!(product: corolla_engine_oil, characteristic_value: viscosity_2)
ProductCharacteristicValue.create!(product: corolla_engine_oil, characteristic_value: volume_3)  # Volume for Corolla Engine Oil (3L)

ProductCharacteristicValue.create!(product: camry_engine_oil, characteristic_value: viscosity_2)
ProductCharacteristicValue.create!(product: camry_engine_oil, characteristic_value: volume_2)  # Volume for Camry Engine Oil (2L)

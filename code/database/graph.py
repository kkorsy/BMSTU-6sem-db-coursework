import pandas as pd
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d
import numpy as np

# Чтение данных из CSV файлов
time_no_index = pd.read_csv('time_no_index.csv', sep=',')
time_index = pd.read_csv('time_index.csv', sep=',')

c1 = np.polyfit(time_no_index['n'], time_no_index['time'], 1)
c1_ = np.polyfit(time_index['n'], time_index['time'], 1)
print(f"c1 no ind: {c1}")
print(f"c1 ind: {c1_}")
c2 = np.polyfit(time_no_index['n'], time_no_index['time'], 2)
c2_ = np.polyfit(time_index['n'], time_index['time'], 2)
print(f"c2 no ind: {c2}")
print(f"c2 ind: {c2_}")

print("y1:", np.poly1d(c1))
print("y2:", np.poly1d(c1_))

# Подписи для данных
labels = ['без индексации', 'с индексацией']

# Создание графика
plt.figure()
# plt.subplot(2, 1, 1)

# Добавление точек для графиков
plt.scatter(time_no_index['n'], time_no_index['time'], color='blue', label=labels[0], marker='^')
plt.scatter(time_index['n'], time_index['time'], color='red', label=labels[1], marker='o')


approx1 = np.polynomial.Polynomial.fit(time_no_index['n'], time_no_index['time'], 1)
plt.plot(time_no_index['n'], approx1(time_no_index['n']), color='blue', linestyle='--')
approx2 = np.polynomial.Polynomial.fit(time_index['n'], time_index['time'], 1)
plt.plot(time_index['n'], approx2(time_index['n']), color='red', linestyle='--')

# Добавление подписей и легенды
plt.xlabel('Количество записей')
plt.ylabel('Время выполнения (мс)')
# plt.title('Сравнение времени выполнения запросов')
plt.legend()
plt.grid(True)

# plt.subplot(2, 1, 2)
# # Добавление точек для графиков
# plt.scatter(time_no_index['n'], time_no_index['time'], color='blue', label=labels[0], marker='^')
# plt.scatter(time_index['n'], time_index['time'], color='red', label=labels[1], marker='o')
#
#
# approx1 = np.polynomial.Polynomial.fit(time_no_index['n'], time_no_index['time'], 2)
# plt.plot(time_no_index['n'], approx1(time_no_index['n']), color='blue', linestyle='--')
# approx2 = np.polynomial.Polynomial.fit(time_index['n'], time_index['time'], 2)
# plt.plot(time_index['n'], approx2(time_index['n']), color='red', linestyle='--')
#
# # Добавление подписей и легенды
# plt.xlabel('Количество записей')
# plt.ylabel('Время выполнения (мс)')
# # plt.title('Сравнение времени выполнения запросов')
# plt.legend()
# plt.grid(True)

# Сохранение графика в файл
plt.savefig('comparison_plot.pdf')
plt.show()

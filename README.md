Identify heat wave or cold wave days from temperature data.

<Syntax>
ind = HC(Ta, threshold, dy)

<Input>
Ta       : Daily maximum (for heat wave) or minimum (for cold wave) temperature (℃),
           specified as an n by m by t matrix, where t is the time dimension.
threshold: Threshold for identifying hot days.
dy       : Day type, specified as a char string: 'HW', 'CW', 'CW1', 'CW2', or 'CW3'.
           'HW'  - Heat wave.
           'CW'  - Cold wave (all types).
           'CW1' - One-day cold wave.
           'CW2' - Two-day cold wave.
           'CW3' - Three-day cold wave.

<Output>
ind      : Logical matrix indicating heat wave or cold wave days. It has the same size as Ta.

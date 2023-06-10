# Zadanie 4 - demonstracja przetwarzania potokowego / algorytmu Tomasulo

Uruchomienie programu:
`make run`

# Zasada działania
Program wykonuje pomiar czasu działania metod `sequential` i `paralel`,
dla każdej metody obliczany jest średni czas ze 100 wykonań.

Obie metody wykonują w pętli (100-krotnie) operacje na liczbach zmiennoprzecinkowych

## Metoda sequential
Wykonuje operacje:
```
    fld1
    fld1
    fld1
    fld1

    // Perform (1 + 1) + 1
    faddp
    faddp
```
Takie ułożenie instrukcji wymusza zależność danych między pierwszą, a drugą opreacją dodawania
Dodatkowa opreacja `fld1` została dodana dla równowagi z metodą paralel (ponieważ zakładam że operacje ładowania na stos x87 są kosztowne)

## Metoda paralel
Wykonuje operacje:
```
    fld1
    fld1
    faddp
    // (1 + 1)

    fld1
    fld1
    faddp
    // (1 + 1)
```
Takie ułożenie instrukcji pozwala na niezależne wykonanie dwóch opreacji dodawania

from pyswip import Prolog
import random

transport = ["bussiga", "laevaga", "rongiga", "lennukiga"]
cities = ["tallinn", "paris", "stockholm", "berlin", "london", "praga", "riim", "narva", "kohtla", "sillamae"]


def make_facts(p):
    for i in range(500):
        city1 = random.choice(cities)
        city2 = city1
        while city2 == city1:
            city2 = random.choice(cities)
        price = random.randint(0, 2000)
        hours = random.randint(0, 23)
        mins = random.randint(0, 59)
        secs = random.randint(0, 59)
        query_str = f"{random.choice(transport)}({city1}, {city2}, {price}, time({hours}, {mins}, {secs}), time({hours + 2}, {mins}, {secs}))"
        p.assertz(query_str)


if __name__ == '__main__':
    p = Prolog()
    p.consult("prax06.pl")
    make_facts(p)
    # for i in p.query("lennukiga(X,Y,Hind,_,_)"):
    #     print(i.get("X"), i.get("Y"), i.get("Hind"))

    print("TEST ODAVAIM REIS")

    for i in range(50):
        city1 = random.choice(cities)
        city2 = city1
        while city2 == city1:
            city2 = random.choice(cities)
        for i in p.query(f"odavaim_reis({city1},{city2},Tee,Hind)"):
            print(f"From {city1} to {city2} Hind = {i.get('Hind')}, Tee = {i.get('Tee')}")

    print("TEST LYHIM REIS")

    for i in range(50):
        city1 = random.choice(cities)
        city2 = city1
        while city2 == city1:
            city2 = random.choice(cities)
        for i in p.query(f"lyhim_reis({city1},{city2},Tee,Hind)"):
            print(f"From {city1} to {city2} Hind = {i.get('Hind')}, Tee = {i.get('Tee')}")

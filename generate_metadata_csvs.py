import csv
from glob import glob


def main():
    coastal = []
    river = []
    with open('tiffs.txt') as fh:
        for line in fh:
            line = line.strip()
            if "inuncoast" in line:
                coastal.append(line)
            else:
                river.append(line)

    with open("aqueduct_coastal.csv", 'w') as fh:
        writer = csv.writer(fh)
        writer.writerow(
            (
                "hazard",
                "climate_scenario",
                "subsidence",
                "year",
                "return_period",
                "sea_level_rise_percentile",
                "key",
                "url",
            )
        )
        for fname in coastal:
            writer.writerow(parse_coastal_fname(fname))

    with open("aqueduct_river.csv", 'w') as fh:
        writer = csv.writer(fh)
        writer.writerow(
            (
                "hazard",
                "climate_scenario",
                "model",
                "year",
                "return_period",
                "key",
                "url",
            )
        )
        for fname in river:
            writer.writerow(parse_river_fname(fname))


def parse_coastal_fname(fname):
    # handle _ for . in decimals
    to_split = fname.replace("1_5", "1.5")
    to_split = to_split.replace("0_0", "0")
    to_split = to_split.replace("2_0", "2")
    to_split = to_split.replace("5_0", "5")
    if "perc" in to_split:
        to_split = to_split.replace("_perc_", "_")
    else:
        to_split = to_split.replace(".tif", "_95.tif")

    to_split = to_split.replace(".tif", "")

    _, climate, subsidence, year, rp, projection = to_split.split("_")

    climate = parse_rcp(climate)

    if year == "hist":
        year = 1980
    else:
        year = int(year)

    rp_string = rp.replace("rp", "")
    try:
        rp = int(rp_string)
    except ValueError:
        rp = float(rp_string)
    projection = int(projection)
    key = f"hazard_coastal__rcp_{climate}__sub_{subsidence}__y_{year}__rp_{rp}__perc_{projection}"
    return "coastal", climate, subsidence, year, rp, projection, key, fname


def parse_river_fname(fname):
    key = fname.replace(".tif", "")
    _, climate, model, year, rp = key.split("_")
    model = model.replace("0", "")
    rp = int(rp.replace("rp", ""))
    climate = parse_rcp(climate)

    key = f"hazard_river__rcp_{climate}__model_{model}__y_{year}__rp_{rp}"
    return "river", climate, model, year, rp, key, fname


def parse_rcp(rcp):
    return rcp.replace("rcp","").replace("p5",".5")

if __name__ == "__main__":
    main()

import csv
from glob import glob


def main():
    coastal = sorted(glob("inuncoast*.tif"))
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
                "filename",
                "key",
            )
        )
        for fname in coastal:
            writer.writerow(parse_coastal_fname(fname))

    river = sorted(glob("inunriver*.tif"))
    with open("aqueduct_river.csv", 'w') as fh:
        writer = csv.writer(fh)
        writer.writerow(
            (
                "hazard",
                "climate_scenario",
                "model",
                "year",
                "return_period",
                "filename",
                "key",
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
    key = f"hazard_coastal__climate_{climate}__sub_{subsidence}__y_{year}__rp_{rp}__perc_{projection}"
    return "coastal", climate, subsidence, year, rp, projection, fname, key


def parse_river_fname(fname):
    key = fname.replace(".tif", "")
    _, climate, model, year, rp = key.split("_")
    model = model.replace("0", "")
    rp = int(rp.replace("rp", ""))

    key = f"hazard_river__climate_{climate}__model_{model}__y_{year}__rp_{rp}"
    return "river", climate, model, year, rp, fname, key


if __name__ == "__main__":
    main()

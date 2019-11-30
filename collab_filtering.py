from recommendation_data import dataset
from math import sqrt


def similarity_score(User1, User2):
    both_viewed = {}

    for item in dataset[User1]:
        if item in dataset[User2]:
            both_viewed[item] = 1

        if len(both_viewed) == 0:
            return 0

        sum_of_eclidean_distance = []

        for item in dataset[User1]:
            if item in dataset[User2]:
                sum_of_eclidean_distance.append(
                    pow(dataset[User1][item] - dataset[User2][item], 2)
                )
        sum_of_eclidean_distance = sums(sum_of_eclidean_distance)

        return 1 / (1 + sqrt(sum_of_eclidean_distance))


def person_correlation(User1, User2):

    both_rated = {}
    for item in dataset[User1]:
        if item in dataset[User2]:
            both_rated[item] = 1

    number_of_ratings = len(both_rated)

    # Checking for ratings in common
    if number_of_ratings == 0:
        return 0

    # Add up all the preferences of each user
    User1_preferences_sum = sum([dataset[User1][item] for item in both_rated])
    User2_preferences_sum = sum([dataset[User2][item] for item in both_rated])

    # Sum up the squares of preferences of each user
    User1_square_preferences_sum = sum(
        [pow(dataset[User1][item], 2) for item in both_rated]
    )
    User2_square_preferences_sum = sum(
        [pow(dataset[User2][item], 2) for item in both_rated]
    )

    product_sum_of_both_users = sum(
        [dataset[User1][item] * dataset[User2][item] for item in both_rated]
    )

    numerator_value = product_sum_of_both_users - (
        User1_preferences_sum * User2_preferences_sum / number_of_ratings
    )
    denominator_value = sqrt(
        (
            User1_square_preferences_sum
            - pow(User1_preferences_sum, 2) / number_of_ratings
        )
        * (
            User2_square_preferences_sum
            - pow(User2_preferences_sum, 2) / number_of_ratings
        )
    )

    if denominator_value == 0:
        return 0
    else:
        r = numerator_value / denominator_value
        return r


def user_recommendations(person):

    totals = {}
    simSums = {}
    rankings_list = []
    for other in dataset:
        if other == person:
            continue
        sim = person_correlation(person, other)

        if sim <= 0:
            continue
        for item in dataset[other]:

            if item not in dataset[person] or dataset[person][item] == 0:

                totals.setdefault(item, 0)
                totals[item] += dataset[other][item] * sim
                simSums.setdefault(item, 0)
                simSums[item] += sim

    rankings = [(total / simSums[item], item) for item, total in totals.items()]
    rankings.sort()
    rankings.reverse()
    # returns the recommended items
    recommendataions_list = [recommend_item for score, recommend_item in rankings]
    return recommendataions_list


def main():

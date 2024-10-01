//
//  Data.swift
//  Airbnb
//
//  Created by dennis savchenko on 10/08/2024.
//

import Foundation

let hosts = [Host(name: "Daniel", picture: "daniel", yearsOfHosting: 2, isSuperhost: true), Host(name: "Olivia", picture: "olivia", yearsOfHosting: 1, isSuperhost: false), Host(name: "Dennis", picture: "dennis", yearsOfHosting: 1, isSuperhost: false)]

let features = [Feature(title: "Self check-in", icon: "door.left.hand.open", description: "Check yourself in with the keypad."), Feature(title: "Great check-in experience", icon: "key", description: "90% of recent guests gave the check-in process a 5-star rating."), Feature(title: "Great communication", icon: "message.badge", description: "90% of recent guests rated the host 5-star in communication."), Feature(title: "Untitled is a Superhost", icon: "star.circle.fill", description: "Superhosts are experienced, highly rated hosts."), Feature(title: "Great location", icon: "mappin.circle", description: "100% of recent guests gave the location 5-star rating.")]

let listings = [
    Listing(
        images: ["1_1", "1_2", "1_3", "1_4"],
        placeType: .flat,
        place: "Brooklyn",
        price: 143.45,
        rating: 4.7,
        title: "Cozy apartment in Brooklyn",
        capacity: 4,
        bedroomsNum: 2,
        bedsNum: 2,
        bathroomNum: 1,
        host: hosts[0], // Daniel
        features: [
            features[0], // Self check-in
            features[1], // Great check-in experience
            features[2]  // Great communication
        ],
        description: "Experience the vibrant energy of Brooklyn from this charming and cozy apartment. Located in a lively neighborhood, this flat offers a perfect blend of comfort and convenience. The space features two beautifully decorated bedrooms with plush bedding, ideal for a restful night’s sleep. The open-plan living area invites you to relax and unwind, with comfortable seating and a flat-screen TV for your entertainment. Enjoy the ease of self check-in with a secure keypad entry, allowing you to arrive at your own convenience. The apartment is praised for its excellent check-in process and top-notch communication, ensuring a seamless stay. You'll find yourself just a short distance from Brooklyn's popular attractions, trendy cafes, and local shops, making it an excellent base for exploring the city. The modern kitchen is fully equipped for your culinary needs, and the cozy dining area is perfect for enjoying meals together. The bathroom is clean and well-appointed, featuring essential amenities and fresh towels. Additional perks include free parking and reliable Wi-Fi, enhancing your overall stay. Whether you're here for a weekend getaway or an extended visit, this apartment promises a comfortable and enjoyable stay with everything you need at your fingertips.",
        offers: ["Free parking", "Wi-Fi", "Air conditioning", "Garden", "Balcony"],
        coordinates: [40.640402, -73.934033]
    ),
    Listing(
        images: ["2_1", "2_2"],
        placeType: .apartment,
        place: "Manhattan",
        price: 160,
        rating: 4.8,
        title: "Modern apartment in Manhattan",
        capacity: 2,
        bedroomsNum: 1,
        bedsNum: 1,
        bathroomNum: 1,
        host: hosts[1], // Olivia
        features: [
            features[2], // Great communication
            features[3], // Untitled is a Superhost
            features[4]  // Great location
        ],
        description: "A modern apartment with stunning city views. Experience the vibrant energy of Brooklyn from this charming and cozy apartment. Located in a lively neighborhood, this flat offers a perfect blend of comfort and convenience. The space features two beautifully decorated bedrooms with plush bedding, ideal for a restful night’s sleep. The space features two beautifully decorated bedrooms with plush bedding. The space features two beautifully decorated bedrooms with plush bedding. with plush bedding. with plush bedding.",
        offers: ["Wi-Fi", "Air conditioning"],
        coordinates: [40.743837, -74.004387]
    ),
    Listing(
        images: ["3_1", "3_2", "3_3"],
        placeType: .house,
        place: "Queens",
        price: 135,
        rating: 4.6,
        title: "Charming house in Queens",
        capacity: 5,
        bedroomsNum: 3,
        bedsNum: 3,
        bathroomNum: 2,
        host: hosts[2], // Dennis
        features: [
            features[1], // Great check-in experience
            features[3], // Untitled is a Superhost
            features[4]  // Great location
        ],
        description: "A charming house in a quiet neighborhood in Queens.",
        offers: ["Garden", "Wi-Fi"],
        coordinates: [40.754301, -73.860349]
    ),
    Listing(
        images: ["4_1", "4_2"],
        placeType: .room,
        place: "Harlem",
        price: 155,
        rating: 4.9,
        title: "Private room in Harlem",
        capacity: 1,
        bedroomsNum: 1,
        bedsNum: 1,
        bathroomNum: 1,
        host: hosts[0], // Daniel
        features: [
            features[0], // Self check-in
            features[2], // Great communication
            features[4]  // Great location
        ],
        description: "A cozy private room in the heart of Harlem.",
        offers: ["Wi-Fi", "Free breakfast"],
        coordinates: [40.818976, -73.955470]
    ),
    Listing(
        images: ["5_1"],
        placeType: .flat,
        place: "The Bronx",
        price: 150,
        rating: 4.5,
        title: "Stylish flat in the Bronx",
        capacity: 3,
        bedroomsNum: 2,
        bedsNum: 2,
        bathroomNum: 1,
        host: hosts[1], // Olivia
        features: [
            features[1], // Great check-in experience
            features[3], // Untitled is a Superhost
            features[4]  // Great location
        ],
        description: "A stylish flat in a vibrant neighborhood in the Bronx.",
        offers: ["Wi-Fi", "TV"],
        coordinates: [40.845741, -73.883250]
    ),
    Listing(
        images: ["6_1", "6_2"],
        placeType: .apartment,
        place: "Lower East Side",
        price: 180,
        rating: 4.7,
        title: "Luxurious apartment in Lower East Side",
        capacity: 4,
        bedroomsNum: 2,
        bedsNum: 2,
        bathroomNum: 2,
        host: hosts[2], // Dennis
        features: [
            features[0], // Self check-in
            features[2], // Great communication
            features[4]  // Great location
        ],
        description: "A luxurious apartment with top amenities.",
        offers: ["Pool", "Wi-Fi", "Gym"],
        coordinates: [40.718440, -73.991014]
    ),
    Listing(
        images: ["7_1", "7_2"],
        placeType: .apartment,
        place: "Staten Island",
        price: 140,
        rating: 4.6,
        title: "Family-friendly house in Staten Island",
        capacity: 6,
        bedroomsNum: 3,
        bedsNum: 3,
        bathroomNum: 2,
        host: hosts[0], // Daniel
        features: [
            features[2], // Great communication
            features[3], // Untitled is a Superhost
            features[4]  // Great location
        ],
        description: "A spacious house perfect for families.",
        offers: ["Backyard", "Wi-Fi"],
        coordinates: [40.575556, -74.233922]
    ),
    Listing(
        images: ["8_1", "8_2", "8_3", "8_4"],
        placeType: .apartment,
        place: "Financial District",
        price: 165,
        rating: 4.8,
        title: "Chic apartment in the Financial District",
        capacity: 3,
        bedroomsNum: 1,
        bedsNum: 2,
        bathroomNum: 1,
        host: hosts[1], // Olivia
        features: [
            features[1], // Great check-in experience
            features[2], // Great communication
            features[4]  // Great location
        ],
        description: "A chic apartment with a view of the city skyline.",
        offers: ["Wi-Fi", "24/7 concierge"],
        coordinates: [40.702666, -74.012054]
    ),
    Listing(
        images: ["9_1", "9_2", "9_3"],
        placeType: .house,
        place: "East Village",
        price: 175,
        rating: 4.9,
        title: "Trendy apartment in East Village",
        capacity: 2,
        bedroomsNum: 1,
        bedsNum: 1,
        bathroomNum: 1,
        host: hosts[2], // Dennis
        features: [
            features[0], // Self check-in
            features[1], // Great check-in experience
            features[3]  // Untitled is a Superhost
        ],
        description: "A trendy apartment in the vibrant East Village.",
        offers: ["Wi-Fi", "Smart TV"],
        coordinates: [40.728469, -73.985716]
    ),
    Listing(
            images: ["10_1"],
            placeType: .flat,
            place: "Greenwich Village",
            price: 145,
            rating: 4.7,
            title: "Charming flat in Greenwich Village",
            capacity: 2,
            bedroomsNum: 1,
            bedsNum: 1,
            bathroomNum: 1,
            host: hosts[1], // Olivia
            features: [
                features[1], // Great check-in experience
                features[2], // Great communication
                features[4]  // Great location
            ],
            description: "A charming flat in the historic and vibrant Greenwich Village.",
            offers: ["Wi-Fi", "Coffee maker"],
            coordinates: [40.735989, -74.003878]
        )
]



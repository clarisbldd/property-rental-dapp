// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PropertyRental {
    struct Property {
        address payable owner;
        string name;
        string description;
        uint pricePerDay;
        bool isRented;
    }

    struct Rental {
        address renter;
        uint rentalDays;
        uint totalAmount;
    }

    Property[] public properties;
    mapping(uint => Rental) public rentals;

    // Event untuk mencatat properti baru
    event PropertyListed(uint propertyId, address owner, string name, uint pricePerDay);
    event PropertyRented(uint propertyId, address renter, uint rentalDays, uint totalAmount);

    // Daftarkan properti baru oleh pemilik
    function listProperty(string memory _name, string memory _description, uint _pricePerDay) public {
        Property memory newProperty = Property({
            owner: payable(msg.sender),
            name: _name,
            description: _description,
            pricePerDay: _pricePerDay,
            isRented: false
        });

        properties.push(newProperty);
        uint propertyId = properties.length - 1;

        emit PropertyListed(propertyId, msg.sender, _name, _pricePerDay);
    }

    // Penyewa menyewa properti
    function rentProperty(uint _propertyId, uint _rentalDays) public payable {
        Property storage property = properties[_propertyId];
        require(!property.isRented, "Property already rented");
        require(msg.value == property.pricePerDay * _rentalDays, "Incorrect rental amount");

        property.isRented = true;

        rentals[_propertyId] = Rental({
            renter: msg.sender,
            rentalDays: _rentalDays,
            totalAmount: msg.values
        });

        property.owner.transfer(msg.value);

        emit PropertyRented(_propertyId, msg.sender, _rentalDays, msg.value);
    }

    // Pemilik mengakhiri penyewaan
    function endRental(uint _propertyId) public {
        Property storage property = properties[_propertyId];
        require(msg.sender == property.owner, "Only owner can end rental");

        property.isRented = false;
    }
}
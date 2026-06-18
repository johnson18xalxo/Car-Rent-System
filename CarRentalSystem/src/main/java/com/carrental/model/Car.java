package com.carrental.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Car {

    private int        carId;
    private String     carName;
    private String     model;
    private String     brand;
    private String     category;
    private String     fuelType;
    private int        seats;
    private BigDecimal pricePerDay;
    private String     imageUrl;
    private boolean    available;
    private String     description;
    private Timestamp  createdAt;

    public Car() {}

    // ── Getters & Setters ────────────────────────────────────────────────

    public int        getCarId()       { return carId;       }
    public String     getCarName()     { return carName;     }
    public String     getModel()       { return model;       }
    public String     getBrand()       { return brand;       }
    public String     getCategory()    { return category;    }
    public String     getFuelType()    { return fuelType;    }
    public int        getSeats()       { return seats;       }
    public BigDecimal getPricePerDay() { return pricePerDay; }
    public String     getImageUrl()    { return imageUrl;    }
    public boolean    isAvailable()    { return available;   }
    public String     getDescription() { return description; }
    public Timestamp  getCreatedAt()   { return createdAt;   }

    public void setCarId(int carId)               { this.carId       = carId;       }
    public void setCarName(String carName)         { this.carName     = carName;     }
    public void setModel(String model)             { this.model       = model;       }
    public void setBrand(String brand)             { this.brand       = brand;       }
    public void setCategory(String category)       { this.category    = category;    }
    public void setFuelType(String fuelType)       { this.fuelType    = fuelType;    }
    public void setSeats(int seats)                { this.seats       = seats;       }
    public void setPricePerDay(BigDecimal p)       { this.pricePerDay = p;           }
    public void setImageUrl(String imageUrl)       { this.imageUrl    = imageUrl;    }
    public void setAvailable(boolean available)    { this.available   = available;   }
    public void setDescription(String description) { this.description = description; }
    public void setCreatedAt(Timestamp createdAt)  { this.createdAt   = createdAt;   }
}

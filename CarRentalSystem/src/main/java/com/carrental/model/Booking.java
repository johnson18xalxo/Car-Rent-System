package com.carrental.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Booking {

    private int        bookingId;
    private int        userId;
    private int        carId;
    private Date       pickupDate;
    private Date       dropoffDate;
    private String     pickupLocation;
    private String     extraInfo;
    private BigDecimal totalAmount;
    private String     status;
    private Timestamp  bookedAt;

    // Denormalised fields (joined from cars/users)
    private String     carName;
    private String     carBrand;
    private String     carModel;
    private String     carImageUrl;
    private String     userFullName;

    public Booking() {}

    // ── Getters & Setters ────────────────────────────────────────────────

    public int        getBookingId()      { return bookingId;      }
    public int        getUserId()         { return userId;         }
    public int        getCarId()          { return carId;          }
    public Date       getPickupDate()     { return pickupDate;     }
    public Date       getDropoffDate()    { return dropoffDate;    }
    public String     getPickupLocation() { return pickupLocation; }
    public String     getExtraInfo()      { return extraInfo;      }
    public BigDecimal getTotalAmount()    { return totalAmount;    }
    public String     getStatus()         { return status;         }
    public Timestamp  getBookedAt()       { return bookedAt;       }
    public String     getCarName()        { return carName;        }
    public String     getCarBrand()       { return carBrand;       }
    public String     getCarModel()       { return carModel;       }
    public String     getCarImageUrl()    { return carImageUrl;    }
    public String     getUserFullName()   { return userFullName;   }

    public void setBookingId(int bookingId)           { this.bookingId      = bookingId;      }
    public void setUserId(int userId)                 { this.userId         = userId;         }
    public void setCarId(int carId)                   { this.carId          = carId;          }
    public void setPickupDate(Date pickupDate)         { this.pickupDate     = pickupDate;     }
    public void setDropoffDate(Date dropoffDate)       { this.dropoffDate    = dropoffDate;    }
    public void setPickupLocation(String l)            { this.pickupLocation = l;              }
    public void setExtraInfo(String extraInfo)         { this.extraInfo      = extraInfo;      }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount    = totalAmount;    }
    public void setStatus(String status)               { this.status         = status;         }
    public void setBookedAt(Timestamp bookedAt)        { this.bookedAt       = bookedAt;       }
    public void setCarName(String carName)             { this.carName        = carName;        }
    public void setCarBrand(String carBrand)           { this.carBrand       = carBrand;       }
    public void setCarModel(String carModel)           { this.carModel       = carModel;       }
    public void setCarImageUrl(String carImageUrl)     { this.carImageUrl    = carImageUrl;    }
    public void setUserFullName(String userFullName)   { this.userFullName   = userFullName;   }

    /** Convenience: number of rental days */
    public long getRentalDays() {
        if (pickupDate == null || dropoffDate == null) return 0;
        long diff = dropoffDate.getTime() - pickupDate.getTime();
        return Math.max(1, diff / (1000 * 60 * 60 * 24));
    }
}

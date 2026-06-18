package com.carrental.model;

import java.sql.Timestamp;

public class User {

    private int       userId;
    private String    fullName;
    private String    email;
    private String    password;   // hashed
    private String    phone;
    private String    address;
    private Timestamp createdAt;

    public User() {}

    public User(int userId, String fullName, String email,
                String password, String phone, String address, Timestamp createdAt) {
        this.userId    = userId;
        this.fullName  = fullName;
        this.email     = email;
        this.password  = password;
        this.phone     = phone;
        this.address   = address;
        this.createdAt = createdAt;
    }

    // ── Getters & Setters ────────────────────────────────────────────────

    public int       getUserId()    { return userId;    }
    public String    getFullName()  { return fullName;  }
    public String    getEmail()     { return email;     }
    public String    getPassword()  { return password;  }
    public String    getPhone()     { return phone;     }
    public String    getAddress()   { return address;   }
    public Timestamp getCreatedAt() { return createdAt; }

    public void setUserId(int userId)          { this.userId    = userId;    }
    public void setFullName(String fullName)   { this.fullName  = fullName;  }
    public void setEmail(String email)         { this.email     = email;     }
    public void setPassword(String password)   { this.password  = password;  }
    public void setPhone(String phone)         { this.phone     = phone;     }
    public void setAddress(String address)     { this.address   = address;   }
    public void setCreatedAt(Timestamp t)      { this.createdAt = t;         }
}

package com.springmvc.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.model.DatabaseSeeder;

@Controller
public class DataController {

  @RequestMapping("/seed-data")
  @ResponseBody
  public String seedData() {
    try {
      DatabaseSeeder.seedDatabase();
      return "✅ Database seeded successfully! Check console for details.";
    } catch (Exception e) {
      e.printStackTrace();
      return "❌ Error seeding database: " + e.getMessage();
    }
  }
}

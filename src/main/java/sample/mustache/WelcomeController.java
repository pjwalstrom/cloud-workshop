/*
 * Copyright 2012-2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package sample.mustache;

import java.sql.*;
import java.util.*;
import java.util.Date;

import com.sun.org.apache.bcel.internal.generic.*;
import jdk.internal.org.objectweb.asm.tree.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.jdbc.core.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WelcomeController {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public WelcomeController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Value("${application.message:Hello World}")
    private String message = "Hello World";

    @RequestMapping("/")
    public String welcome(Map<String, Object> model) {

        Name name = jdbcTemplate.queryForObject("SELECT * FROM PERSON",
                (rs, rowNum) -> new Name(rs.getString(1), rs.getString(2)));

        model.put("time", new Date());
        model.put("message", String.format("Hello %s", name.fullName()));

        return "welcome";
    }

    private static class Name {
        private String fullName;

        public Name(String firstName, String lastName) {
            fullName = firstName + ' ' + lastName;
        }

        public String fullName() {
            return fullName;
        }
    }
}

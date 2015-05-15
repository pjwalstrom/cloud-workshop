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

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.*;

import java.net.*;
import java.util.*;

@Controller
public class WelcomeController {

    @Value("${backend.url}")
    private URI backend;

    @RequestMapping("/")
    public String welcome(Map<String, Object> model) {
        Name name = new RestTemplate().getForObject(backend, Name.class);

        model.put("time", new Date());
        model.put("message", String.format("Hello %s", name.fullName()));

        return "welcome";
    }

    private static class Name {
        private String firstName;
        private String lastName;

        public String fullName() {
            return firstName + ' ' + lastName;
        }

        public void setFirstName(String firstName) {
            this.firstName = firstName;
        }

        public void setLastName(String lastName) {
            this.lastName = lastName;
        }
    }
}

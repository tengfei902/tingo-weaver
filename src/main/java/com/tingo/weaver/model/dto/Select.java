package com.tingo.weaver.model.dto;

import com.tingo.weaver.utils.enums.TdType;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by user on 17/10/17.
 */
public class Select extends Input {
    private String optionCheckFunction;
    private List<Option> options;
    private String onChangeAction;

    public Select(String id, TdType tdType, String name, String value) {
        super(id, tdType, name, value);
    }

    public Select(String id, TdType tdType, String name) {
        super(id, tdType, name);
    }

    public Select optionCheck(String optionCheckFunction) {
        this.optionCheckFunction = optionCheckFunction;
        return this;
    }

    public Select addOption(Option option) {
        if(CollectionUtils.isEmpty(options)) {
            this.options = new ArrayList<>();
        }
        options.add(option);
        return this;
    }

    public Select onChange(String onChangeAction) {
        this.onChangeAction = onChangeAction;
        return this;
    }

    public String getOptionCheckFunction() {
        return optionCheckFunction;
    }

    public List<Option> getOptions() {
        return options;
    }

    public String getOnChangeAction() {
        return onChangeAction;
    }
}

/**
 * Generate a markdown file featuring all the environment variables and their example values.
 */

const fs = require("fs");
const Yaml = require("js-yaml");

const sourceFile = ".tugboat/env-vars.yml";
const destFile = "public/vars.md";
const output = [];

/**
 * Helper to render the sections of tables of variables.
 *
 * @type {{getEnvVarVal: (function(*): string), printVars: Renderer.printVars, printSection: Renderer.printSection}}
 */
const Renderer = {
  /**
   * Print a section of variables.
   *
   * @param section
   * @param headerLevel
   */
  printSection: (section, headerLevel) => {
    const head = "".padStart(headerLevel, "#");

    // Print the section name.
    output.push(`${head} ${section.name}`);
    output.push("");

    // Add the section description.
    if (typeof section.desc !== "undefined") {
      output.push(`${section.desc}`);
      output.push("");
    }

    // If this section has subsections, add a level.
    if (typeof section.sections !== "undefined") {
      // Iterate over the sections to print the headings.
      section.sections.forEach(section => {
        Renderer.printSection(section, 3);
      });
    }

    if (typeof section.vars !== "undefined") {
      Renderer.printVars(section.vars);
    }
  },

  /**
   * Generate the table of variables.
   *
   * @param vars
   */
  printVars: (vars) => {
    // Protect against empty sections.
    vars = vars || [];

    // Create the table headings.
    output.push("| Variable Name | Description | Example Value |");
    output.push("|:--------------|:------------|:--------------|");

    // Iterate over all variables in each section.
    vars.forEach(variable => {
      // Ensure we have a value so the app doesn't die.
      let envVarVal = Renderer.getEnvVarVal(variable);

      // Add the row to the table.
      output.push(`| **\`$${variable.name}\`** | ${variable.desc} | ${envVarVal} |`);
    });

    output.push("");
  },

  /**
   * Get the value of a particular variable or its override.
   *
   * @param envVar
   * @returns {string}
   */
  getEnvVarVal: (envVar) => {
    let envVarValName = typeof envVar.override !== 'undefined' ? envVar.override : envVar.name;
    let envVarValRefName = `process.env.${envVarValName}`;

    let envVarVal = "";
    if (typeof eval(envVarValRefName) !== "undefined") {
      envVarVal = '`' + eval(envVarValRefName) + '`';
    }

    return envVarVal;
  }
};

// Run it!
try {
  // Read the variable data.
  const data = Yaml.load(fs.readFileSync(sourceFile, "utf8"));

  // Iterate over the sections to print the headings.
  data.sections.forEach(section => {
    Renderer.printSection(section, 2);
  });

  // Write the file.
  fs.writeFileSync(destFile, output.join("\n"));
  console.log(`Wrote variables to ${destFile}`);
} catch (e) {
  console.log(e);
}
